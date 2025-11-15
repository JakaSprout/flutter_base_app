# Assets Directory

Direktori ini berisi assets yang diperlukan untuk aplikasi.

## Required Files

### Splash Screen
- **Path**: `images/splash.png`
- **Format**: PNG
- **Recommended size**: 200x200 pixels
- **Color profile**: sRGB
- **No interlacing**

### App Icon
- **Path**: `icons/app_icon.png`
- **Format**: PNG
- **Recommended size**: 1024x1024 pixels
- **Square format** (1:1 aspect ratio)
- **No transparency** (untuk iOS, akan di-remove otomatis)

## Setup Instructions

1. Tambahkan file `splash.png` ke `assets/images/`
2. Tambahkan file `app_icon.png` ke `assets/icons/`
3. Pastikan file sudah ditambahkan ke `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/splash.png
    - assets/icons/app_icon.png
```

4. Jalankan generate commands:
   - Splash: `dart run flutter_native_splash:create --path=flutter_native_splash.yaml`
   - Icons per flavor:
     - Dev: `dart run flutter_launcher_icons -f flutter_launcher_icons-dev.yaml`
     - Staging: `dart run flutter_launcher_icons -f flutter_launcher_icons-staging.yaml`
     - Prod: `dart run flutter_launcher_icons -f flutter_launcher_icons-prod.yaml`

## Flavor-Specific Assets (Optional)

Jika ingin menggunakan assets berbeda per flavor:
- `images/splash_dev.png`, `images/splash_staging.png`, `images/splash_prod.png`
- `icons/app_icon_dev.png`, `icons/app_icon_staging.png`, `icons/app_icon_prod.png`

Kemudian update konfigurasi di `flutter_native_splash.yaml` dan file `flutter_launcher_icons-<flavor>.yaml` yang sesuai.

