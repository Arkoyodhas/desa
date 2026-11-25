<?php
/** Menyajikan foto terproteksi (watermark + anti hotlink) dan streaming musik. */
class MediaController extends Controller {

    public array $actions = ['foto', 'galeri', 'musik'];

    public function index(): void { $this->notFound(); }

    public function foto($id = null): void {
        $row = db_row("SELECT foto FROM village_officials WHERE id = ? AND is_active = 1", [(int) $id]);
        $this->servePhoto($row['foto'] ?? null, setting('photo_protection', '1') === '1', setting('photo_watermark', '1') === '1');
    }

    public function galeri($id = null): void {
        $row = db_row("SELECT file_path, protected, watermark FROM galleries WHERE id = ? AND is_active = 1", [(int) $id]);
        $this->servePhoto($row['file_path'] ?? null, (bool) ($row['protected'] ?? false), (bool) ($row['watermark'] ?? false));
    }

    private function servePhoto(?string $relPath, bool $protect, bool $watermark): void {
        if (!$relPath) { $this->placeholder(); }
        $file = $this->resolveUploadFile($relPath);
        if ($file === null) { $this->placeholder(); }

        // proteksi hotlink dasar: referer harus dari host sendiri (jika ada)
        if ($protect && !empty($_SERVER['HTTP_REFERER'])) {
            $refHost = parse_url($_SERVER['HTTP_REFERER'], PHP_URL_HOST);
            $ownHost = $_SERVER['HTTP_HOST'] ?? '';
            if ($refHost && strcasecmp($refHost, explode(':', $ownHost)[0]) !== 0) {
                http_response_code(403); exit;
            }
        }

        $mime = mime_content_type($file) ?: 'image/jpeg';
        if ($watermark && function_exists('imagecreatefromjpeg')) {
            $cacheDir = BASE_PATH . '/uploads/cache';
            if (!is_dir($cacheDir)) mkdir($cacheDir, 0755, true);
            $cache = $cacheDir . '/wm_' . md5($relPath . filemtime($file) . setting('watermark_text')) . '.jpg';
            if (!is_file($cache)) $this->applyWatermark($file, $mime, $cache);
            if (is_file($cache)) { $file = $cache; $mime = 'image/jpeg'; }
        }
        header('Content-Type: ' . $mime);
        header('Content-Length: ' . filesize($file));
        header('Cache-Control: ' . ($protect ? 'private, no-store' : 'public, max-age=86400'));
        header('X-Content-Type-Options: nosniff');
        readfile($file);
        exit;
    }

    private function applyWatermark(string $src, string $mime, string $dest): void {
        $img = match ($mime) {
            'image/png' => @imagecreatefrompng($src),
            'image/webp' => @imagecreatefromwebp($src),
            default => @imagecreatefromjpeg($src),
        };
        if (!$img) return;
        $w = imagesx($img); $h = imagesy($img);
        $text = setting('watermark_text', setting('village_name', 'Desa'));
        $layer = imagecreatetruecolor($w, $h);
        imagealphablending($layer, false); imagesavealpha($layer, true);
        $transparent = imagecolorallocatealpha($layer, 0, 0, 0, 127);
        imagefill($layer, 0, 0, $transparent);
        $white = imagecolorallocatealpha($layer, 255, 255, 255, 70);
        $font = 5;
        $tw = imagefontwidth($font) * strlen($text);
        for ($y = 40; $y < $h; $y += 130) {
            for ($x = -20; $x < $w; $x += $tw + 90) {
                imagestring($layer, $font, $x, $y, $text, $white);
            }
        }
        imagecopy($img, $layer, 0, 0, 0, 0, $w, $h);
        imagejpeg($img, $dest, 80);
        imagedestroy($img); imagedestroy($layer);
    }

    /** Pastikan path selalu berada di dalam uploads dan bukan symlink keluar. */
    private function resolveUploadFile(?string $relative): ?string {
        $relative = ltrim(str_replace('\\', '/', trim((string) $relative)), '/');
        if ($relative === '' || str_contains($relative, '..')) return null;
        $root = realpath(BASE_PATH . '/uploads');
        $file = realpath(BASE_PATH . '/uploads/' . $relative);
        if ($root === false || $file === false || !is_file($file)
            || !str_starts_with($file, $root . DIRECTORY_SEPARATOR)) return null;
        return $file;
    }

    private function placeholder(): void {
        header('Content-Type: image/svg+xml');
        echo '<svg xmlns="http://www.w3.org/2000/svg" width="400" height="500" viewBox="0 0 400 500"><rect width="400" height="500" fill="#e5ece9"/><circle cx="200" cy="180" r="70" fill="#b6c9c2"/><rect x="90" y="290" width="220" height="150" rx="75" fill="#b6c9c2"/></svg>';
        exit;
    }

    public function musik($id = null): void {
        $row = db_row("SELECT file_path FROM background_music
            WHERE id = ? AND is_active = 1", [(int) $id]);
        if (!$row || !$row['file_path']) { http_response_code(404); exit; }

        $file = $this->resolveUploadFile((string) $row['file_path']);
        if ($file === null || !is_readable($file)) { http_response_code(404); exit; }

        $ext = strtolower(pathinfo($file, PATHINFO_EXTENSION));
        $allowed = ['mp3' => 'audio/mpeg', 'wav' => 'audio/wav', 'ogg' => 'audio/ogg'];
        if (!isset($allowed[$ext])) { http_response_code(415); exit; }
        $detected = function_exists('mime_content_type') ? (string) @mime_content_type($file) : '';
        if ($detected !== '' && !str_starts_with($detected, 'audio/')
            && $detected !== 'application/octet-stream') {
            http_response_code(415); exit;
        }
        $mime = $allowed[$ext];
        $size = (int) filesize($file);
        $start = 0;
        $end = max(0, $size - 1);
        $status = 200;

        header('Content-Type: ' . $mime);
        header('Accept-Ranges: bytes');
        header('Cache-Control: public, max-age=86400, immutable');
        header('X-Content-Type-Options: nosniff');

        $range = (string) ($_SERVER['HTTP_RANGE'] ?? '');
        if ($range !== '' && preg_match('/^bytes=(\d*)-(\d*)$/i', trim($range), $m)) {
            if ($m[1] === '' && $m[2] !== '') {
                // Suffix range, contoh bytes=-500 berarti 500 byte terakhir.
                $suffix = min($size, max(0, (int) $m[2]));
                $start = max(0, $size - $suffix);
                $end = max(0, $size - 1);
            } else {
                $start = max(0, (int) ($m[1] !== '' ? $m[1] : 0));
                if ($m[2] !== '') $end = min($end, (int) $m[2]);
            }

            if ($start > $end || $start >= $size) {
                http_response_code(416);
                header("Content-Range: bytes */{$size}");
                exit;
            }
            $status = 206;
        }

        $length = $end - $start + 1;
        http_response_code($status);
        if ($status === 206) header("Content-Range: bytes {$start}-{$end}/{$size}");
        header('Content-Length: ' . $length);

        // Safari/iOS sering melakukan HEAD sebelum GET.
        if (strtoupper((string) ($_SERVER['REQUEST_METHOD'] ?? 'GET')) === 'HEAD') exit;

        $fp = fopen($file, 'rb');
        if ($fp === false) { http_response_code(500); exit; }
        if ($start > 0) fseek($fp, $start);

        $remaining = $length;
        while ($remaining > 0 && !feof($fp)) {
            $chunk = fread($fp, min(8192, $remaining));
            if ($chunk === false || $chunk === '') break;
            echo $chunk;
            $remaining -= strlen($chunk);
            if (connection_aborted()) break;
        }
        fclose($fp);
        exit;
    }
}
