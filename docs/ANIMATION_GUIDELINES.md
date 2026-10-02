# Dekho Animation Guidelines

Animations in Dekho should feel purposeful, responsive, and premium. They guide the user's attention and provide immediate feedback without feeling sluggish.

## Core Motion Tokens
*Defined in `AppMotion` (`lib/core/theme/app_motion.dart`)*

### Durations
- **Fast (150ms):** Used for micro-interactions. State changes that require instant feedback.
- **Standard (300ms):** Used for most UI transitions, expansions, and element entrances.
- **Slow (500ms):** Used for complex layout changes or celebratory animations to draw focus.
- **Page (400ms):** Specifically tuned for route navigation.

### Curves
- **`standardCurve` (easeInOut):** The default for elements moving within the screen bounds. Starts slowly, accelerates, then decelerates.
- **`decelerate`:** Used for elements entering the screen (e.g., sliding up). They start fast and slow down as they reach their final position.
- **`accelerate` (easeIn):** Used for elements leaving the screen. They start slow and speed up as they exit.
- **`spring` (elasticOut):** Used sparingly for playful or physical interactions (bottom sheets, badges).

## Specific Animation Patterns

### 1. Button Press Scale
- **Action:** User taps a primary or secondary button.
- **Animation:** Button scales down to `0.95` instantly (0ms), then scales back to `1.0` using `AppMotion.fast` and `Curves.easeOut`.
- **Purpose:** Tactile confirmation of touch.

### 2. Wishlist Heart Toggle
- **Action:** User taps the wishlist icon on a product.
- **Animation:** 
  1. Color crossfades from `neutral400` to `error` (red).
  2. Icon scales up to `1.3x` using `fast` duration.
  3. Icon scales down to `1.0x` using `spring` curve over `standard` duration.

### 3. Product Card Entrance
- **Action:** A list or grid of products loads (e.g., on Home or Search Results).
- **Animation:** Staggered entrance. Each card slides up by 20px and fades in (Opacity 0 -> 1) using `standard` duration and `decelerate` curve. Each subsequent item is delayed by 50ms.
- **Implementation:** Use the `AnimatedListItem` widget.

### 4. Search Bar Expansion
- **Action:** User taps the read-only search bar on the Home screen, routing to the Search screen.
- **Animation:** Hero transition. The search bar seamlessly expands to the top with a `standard` duration, taking focus automatically.

### 5. Price Transitions
- **Action:** A filter is applied, or the active retailer changes on the product detail page, causing the price to change.
- **Animation:** Use `AnimatedSwitcher` to crossfade or vertically slide the old price out and the new price in.

### 6. Shimmer Loading
- **Action:** Waiting for mock network delay or future API response.
- **Animation:** A continuous, smooth gradient sweep from left to right over grey container blocks.
- **Colors:** `shimmerBase` to `shimmerHighlight`.
- **Implementation:** Use `ShimmerLoading` pre-built constructors.

### 7. Bottom Sheets
- **Action:** User opens filters or sorting.
- **Animation:** Slides up from the bottom using a slight `spring` curve to feel physical and grounded.

### 8. Pull-to-Refresh
- **Action:** User drags down at the top of a scroll view.
- **Animation:** Native platform feel (Material RefreshIndicator on Android, CupertinoSliverRefreshControl on iOS).
