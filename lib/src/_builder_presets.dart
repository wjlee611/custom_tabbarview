part of 'custom_tabbarview.dart';

// ========================================
// MARK: fadeBuilder
// ========================================

/// {@template _CustomTabBarViewFadeBuilderDelegate}
///
/// A builder that sets opacity to 0% at 50% of the way
/// through a screen transition.
///
/// {@endtemplate}
class _CustomTabBarViewFadeBuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
  /// {@macro _CustomTabBarViewFadeBuilderDelegate}
  const _CustomTabBarViewFadeBuilderDelegate();

  @override
  Widget build(
    BuildContext context,
    PageController pageController,
    List<Widget> childrenWithKey,
    int index,
  ) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        final offset = calcOffset(pageController, index);

        final opacity = 1 - offset.abs() * 2;

        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: child,
        );
      },
      child: childrenWithKey[index],
    );
  }
}

// ========================================
// MARK: stackBuilder
// ========================================

/// {@template _CustomTabBarViewStackBuilderDelegate}
///
/// A builder where the page on the right is stacked
/// above the page on the left.
///
/// {@endtemplate}
class _CustomTabBarViewStackBuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
  /// {@macro _CustomTabBarViewStackBuilderDelegate}
  const _CustomTabBarViewStackBuilderDelegate();

  @override
  Widget build(
    BuildContext context,
    PageController pageController,
    List<Widget> childrenWithKey,
    int index,
  ) {
    final width = MediaQuery.sizeOf(context).width;
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        final offset = calcOffset(pageController, index);

        final dx = (offset > 0 ? offset : -math.log(1 - offset)) * width * 0.8;
        final scale = 1 - offset * 0.2;
        final opacity = 1 - offset.abs();

        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: scale,
            child: Transform.translate(offset: Offset(dx, 0), child: child),
          ),
        );
      },
      child: childrenWithKey[index],
    );
  }
}

// ========================================
// MARK: carouselBuilder
// ========================================

/// {@template _CustomTabBarViewCarouselBuilderDelegate}
///
/// This builder adds a fade to add naturalness to carousel-style transitions.
///
/// {@endtemplate}
class _CustomTabBarViewCarouselBuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
  /// {@macro _CustomTabBarViewCarouselBuilderDelegate}
  const _CustomTabBarViewCarouselBuilderDelegate();

  @override
  Widget build(
    BuildContext context,
    PageController pageController,
    List<Widget> childrenWithKey,
    int index,
  ) {
    final width = MediaQuery.sizeOf(context).width;
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        final offset = calcOffset(pageController, index);

        final dx = offset * width * 0.8;
        final scale = 1 - offset.abs() * 0.1;
        final opacity = 1 - offset.abs() * 2;

        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: scale,
            child: Transform.translate(offset: Offset(dx, 0), child: child),
          ),
        );
      },
      child: childrenWithKey[index],
    );
  }
}

// ========================================
// MARK: toss1Builder
// ========================================

/// {@template _CustomTabBarViewToss1BuilderDelegate}
///
/// Builders that have implemented the transitions used in Toss apps.
///
/// {@endtemplate}
class _CustomTabBarViewToss1BuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
  /// {@macro _CustomTabBarViewToss1BuilderDelegate}
  const _CustomTabBarViewToss1BuilderDelegate();

  @override
  Widget build(
    BuildContext context,
    PageController pageController,
    List<Widget> childrenWithKey,
    int index,
  ) {
    final width = MediaQuery.sizeOf(context).width;
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        final offset = calcOffset(pageController, index);

        final dx = offset * width * 0.95;
        final opacity = 1 - offset.abs() * 1.2;

        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.translate(offset: Offset(dx, 0), child: child),
        );
      },
      child: childrenWithKey[index],
    );
  }
}

// ========================================
// MARK: toss2Builder
// ========================================

/// {@template _CustomTabBarViewToss2BuilderDelegate}
///
/// Builders that have implemented the transitions used in Toss apps.
///
/// {@endtemplate}
class _CustomTabBarViewToss2BuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
  /// {@macro _CustomTabBarViewToss2BuilderDelegate}
  const _CustomTabBarViewToss2BuilderDelegate();

  @override
  Widget build(
    BuildContext context,
    PageController pageController,
    List<Widget> childrenWithKey,
    int index,
  ) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        final offset = calcOffset(pageController, index);

        final scale = 0.95 + (0.5 - offset.abs()).abs() * 0.1;

        return Transform.scale(
          scale: scale.abs(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular((1 - scale).abs() * 300),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withAlpha(((1 - scale).abs() * 500).round()),
                  spreadRadius: 2,
                  blurRadius: 2,
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: child,
          ),
        );
      },
      child: childrenWithKey[index],
    );
  }
}
