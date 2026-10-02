# Dekho Design System

This document outlines the visual design language and tokens used in the Dekho app. It serves as the single source of truth for all UI components.

## Color Palette

The app uses Electric Indigo as the primary brand color, conveying a premium and trustworthy feel.

### Brand Colors
- **Primary:** `#6366F1` (Electric Indigo) - Main brand color, buttons, active states
- **Primary Light:** `#818CF8` - Hover states, subtle highlights
- **Primary Dark:** `#4F46E5` - Pressed states
- **Primary Surface:** `#EEF2FF` - Very light background for primary-tinted areas

### Secondary Colors
- **Secondary:** `#0EA5E9` (Sky Blue) - Accents, secondary actions
- **Secondary Light:** `#38BDF8`
- **Secondary Dark:** `#0284C7`

### Semantic Colors
- **Success:** `#22C55E` - Best deals, in-stock status (Light: `#BBF7D0`, Surface: `#F0FDF4`)
- **Warning:** `#F59E0B` - Low stock, ratings (Light: `#FDE68A`, Surface: `#FFFBEB`)
- **Error:** `#EF4444` - Out of stock, error states (Light: `#FECACA`, Surface: `#FEF2F2`)
- **Info:** `#3B82F6` - General information

### Neutral Colors
- **Background:** `#F8FAFC` - Main app background
- **Surface/Card:** `#FFFFFF` - Component backgrounds
- **Text Primary:** `#0F172A` - Headings, main text
- **Text Secondary:** `#64748B` - Subtitles, metadata
- **Text Tertiary:** `#94A3B8` - Disabled text, hints
- **Border:** `#E2E8F0` - Dividers, subtle borders
- **Divider:** `#F1F5F9`

### Retailer Brand Colors
- **Amazon:** `#xFFFF9900`
- **Flipkart:** `#FF2874F0`
- **Croma:** `#FF00B060`
- **Myntra:** `#FFFF3F6C`
- **Reliance Digital:** `#FF003B71`
- **Tata CLiQ:** `#FF9C1F61`

## Typography

**Font Family:** Plus Jakarta Sans

| Style | Weight | Size | Height | Usage |
|-------|--------|------|--------|-------|
| Display | 800 (ExtraBold) | 32px | 1.2 | Splash screens, major numbers |
| H1 | 700 (Bold) | 28px | 1.25 | Large screen titles |
| H2 | 700 (Bold) | 24px | 1.3 | Section headers, bottom sheet titles |
| H3 | 600 (SemiBold) | 20px | 1.35 | Card titles, minor headers |
| Body | 400 (Regular) | 16px | 1.5 | General paragraph text |
| Body Medium | 500 (Medium) | 16px | 1.5 | Emphasized body text |
| Body Small | 400 (Regular) | 14px | 1.5 | Metadata, descriptions |
| Caption | 400 (Regular) | 12px | 1.4 | Very small disclaimers |
| Price Large | 800 (ExtraBold) | 28px | 1.2 | Product Detail main price (Tabular) |
| Price | 700 (Bold) | 20px | 1.3 | Card prices (Tabular) |
| Price Small | 600 (SemiBold) | 16px | 1.3 | Inline prices, original prices (Tabular) |
| Label | 600 (SemiBold) | 12px | 1.2 | ALL CAPS tags, badges (0.8px tracking) |

## Spacing Scale
- `xxs`: 4px - Between tight elements (icon and text)
- `xs`: 8px - Small inner component padding
- `sm`: 12px - Standard inner padding
- `md`: 16px - Default screen margin, standard spacing
- `lg`: 24px - Section spacing
- `xl`: 32px - Large section spacing
- `xxl`: 48px - Screen edge to major elements
- `xxxl`: 64px - Empty states padding

## Radius Scale
- `xs`: 4px - Small badges, tags
- `sm`: 8px - Inner elements, search bar
- `md`: 12px - Standard cards, buttons
- `lg`: 16px - Large cards, bottom sheets
- `xl`: 24px - Prominent containers
- `full`: 999px - Circular avatars, FABs

## Shadows
- **Subtle:** Y: 2, Blur: 8, Black 4% - Resting cards
- **Card:** Y: 4, Blur: 16, Black 6% - Hovered cards, slightly elevated
- **Elevated:** Y: 8, Blur: 24, Black 8% - Floating action buttons
- **Modal:** Y: 16, Blur: 48, Black 16% - Bottom sheets, dialogs

## Motion
- **Fast:** 150ms - Color changes, button presses (Curve: easeInOut)
- **Standard:** 300ms - Expansion panels, tooltips (Curve: easeInOut)
- **Slow:** 500ms - Complex state changes
- **Page:** 400ms - Route transitions
- **Spring:** elasticOut curve for bottom sheets and playful elements.

## Iconography
**Library:** Lucide Icons
**Sizes:**
- `xs`: 16px - Inline with small text
- `sm`: 20px - Standard inline
- `md`: 24px - Default icon size (App bars, nav)
- `lg`: 32px - Prominent actions
- `xl`: 48px - Empty state illustrations

## Component Heights
- **Buttons:** 48px (standard), 40px (small), 56px (large)
- **Search Bar:** 52px
- **Bottom Nav:** 64px + safe area
- **Bottom Sheets:** Dynamic, max 90% screen height

## Dark Mode Plan (Future)
Currently, Dekho is designed primarily for Light Mode. In the future, semantic colors will adapt:
- Backgrounds will invert to `neutral900` (`#0F172A`).
- Surfaces to `neutral800` (`#1E293B`).
- Text will invert to `neutral50` (`#F8FAFC`).
- Brand colors will remain consistent but may use the `Light` variants for better contrast against dark backgrounds.
