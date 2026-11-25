-- v9: Banner slider galeri (gaya Netflix) di beranda. Juga dibuat otomatis oleh AdminSchema::ensureGalleryBanner().
ALTER TABLE `galleries`
  ADD COLUMN IF NOT EXISTS `is_banner` TINYINT(1) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `banner_title` VARCHAR(150) NULL,
  ADD COLUMN IF NOT EXISTS `banner_desc` VARCHAR(400) NULL,
  ADD COLUMN IF NOT EXISTS `banner_order` INT NOT NULL DEFAULT 99;
