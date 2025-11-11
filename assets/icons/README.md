# Icons Directory

Struktur folder untuk SVG icons dari Figma design system.

## 📁 Folder Structure

```
icons/
├── outline/    # Outline variant icons (SVG)
├── solid/      # Solid variant icons (SVG)
└── bulk/       # Bulk variant icons (SVG)
```

## 📋 Naming Convention

- Use **kebab-case** untuk file names: `arrow-down.svg`, `calendar.svg`
- Generated code akan convert ke **camelCase**: `arrowDown`, `calendar`

## 🎨 Icon Variants

Berdasarkan design system Figma:

### Outline
- Icons dengan outline/stroke style
- Example: `arrow-down.svg`, `calendar.svg`, `time.svg`

### Solid
- Icons dengan filled/solid style
- Example: `arrow-down.svg`, `remove.svg`, `download.svg`

### Bulk
- Icons dengan bulk/weighted style
- Example: `arrow-down.svg`, `chart.svg`, `property.svg`

## 📥 Export dari Figma

1. Select icon di Figma
2. Export sebagai SVG
3. Place di folder sesuai variant:
   - Outline icons → `outline/`
   - Solid icons → `solid/`
   - Bulk icons → `bulk/`

## 🚀 Usage

Setelah generate dengan `flutter_gen`, gunakan:

```dart
import 'package:flutter_base_app/gen/assets.gen.dart';

// Outline icon
Assets.icons.outline.arrowDown.svg()

// Solid icon
Assets.icons.solid.arrowDown.svg()

// Bulk icon
Assets.icons.bulk.chart.svg()
```

## 📝 Notes

- Pastikan SVG icons sudah di-export dengan benar dari Figma
- Use consistent naming untuk semua variants
- Keep SVG files optimized untuk better performance

