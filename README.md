# Fakestore Product Listing (Daraz-style single-scroll)

This repo contains a Flutter screen (`DarazListingPage`) that demonstrates **single vertical scroll ownership** with a collapsible header, a pinned/sticky tab bar, pull-to-refresh from any tab, and predictable horizontal swipe navigation between tabs.

## Run

```Login Credential
"username": "mor_2314",
"password": "83r5^_",
```

## Mandatory explanation (scroll + gesture architecture)

### 1) How horizontal swipe was implemented

- **Where**: `lib/app/product_listing/view/daraz_listing_page.dart`
- **How**: The page is wrapped in a `GestureDetector` that listens only to `onHorizontalDragEnd`.
- **Behavior**: On a horizontal fling (velocity threshold), it calls `TabController.animateTo(prev/next)`.
- **Why**: This enables swipe-based tab switching **without introducing any additional scrollables** (no `TabBarView` / `PageView`), which helps keep vertical scroll ownership unambiguous.

### 2) Who owns the vertical scroll and why

- **Owner**: A single `CustomScrollView` is the **only** vertical scrollable on the screen.
- **Why**:
  - The collapsible header and the product list are both built as slivers inside that one `CustomScrollView`.
  - Each tab does **not** create its own inner `ListView`/`ScrollView`. Switching tabs only changes the data used by the one `SliverList`.
  - `RefreshIndicator` wraps the same `CustomScrollView`, so pull-to-refresh works from any tab.

### 3) Trade-offs / limitations

- **Shared scroll position across tabs**: Because there is only one vertical scrollable, all tabs share the same vertical offset (intentional to avoid nested scroll conflicts).
- **Custom swipe implementation**: Swipe behavior is manual (velocity-based) rather than using `TabBarView`’s default paging, but it is more predictable here because it avoids extra scrollables.
- **Header collapse clipping**: The header is clipped during collapse to prevent layout overflow; content is not fully visible when the header is at its minimum height (by design).

## API

- **Base URL**: `https://fakestoreapi.com`
- **Docs**: `https://fakestoreapi.com/docs`
