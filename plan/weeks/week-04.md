# Week 4 — Material Theming, Icons, Animations, Accessibility

| Class | Date | Syllabus (Kotlin) | Flutter version |
|---|---|---|---|
| 7 | 06.10 | Material Theming + Icons | `ThemeData`, Material 3, `ColorScheme.fromSeed`, fonts, launcher icons |
| 8 | 08.10 | Animations + Accessibility | Implicit/explicit animations, `Hero`, `Semantics` |

## Class 7 — Theming & icons
1. `MaterialApp(theme:, darkTheme:, themeMode:)`.
2. `ColorScheme.fromSeed(seedColor: ..., brightness: ...)`; read colours with `Theme.of(context).colorScheme.primary` instead of `Colors.black`.
3. `TextTheme` and `google_fonts`; component themes (`AppBarTheme`, `CardTheme`, `IconButtonTheme`).
4. `Icons.*` and `Icons.*_outlined`; custom SVG icons via `flutter_svg`.
5. App launcher icon with `flutter_launcher_icons` (the Image Asset Studio equivalent).

## Class 8 — Animations + accessibility
1. Implicit animations: `AnimatedContainer`, `AnimatedOpacity`, `AnimatedSlide`, `AnimatedSwitcher`, `AnimatedSize`, `TweenAnimationBuilder`.
2. **Case study:** `lib/widgets/animated_indexed_stack.dart`. Why `TickerMode` sits inside the transitions, why `RepaintBoundary` is there, and how lazy building with `_visited` works.
3. Explicit animations: `AnimationController` + `SingleTickerProviderStateMixin` + `CurvedAnimation` + `AnimatedBuilder`; always `dispose()` the controller.
4. `Hero` transitions between screens.
5. Accessibility: `Semantics`, `semanticLabel`, `tooltip` on `IconButton`, minimum 48×48 tap targets, `MediaQuery.textScalerOf`, contrast. Test with TalkBack and with large font settings.

**Lab:** Superheroes (see [labs.md](../labs.md#l3--superheroes-week-4)).

## Repo milestone
- `lib/app/theme.dart` with light and dark themes; remove every hard-coded `Colors.*` in `lib/`.
- Instagram-style double-tap to like: a big heart scales in and fades out over the image (`AnimationController` + `ScaleTransition`).
- `tooltip: 'Like'`, `'Comment'`, `'Share'`, `'Save'` on the action buttons; `semanticLabel` on post images.
