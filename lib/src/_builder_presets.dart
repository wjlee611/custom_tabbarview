part of 'custom_tabbarview.dart';

// ========================================
// MARK: fadeBuilder
// ========================================

/// A builder that sets opacity to 0% at 50% of the way
/// through a screen transition.
class _CustomTabBarViewFadeBuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
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

/// A builder where the page on the right is stacked
/// above the page on the left.
class _CustomTabBarViewStackBuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
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

/// This builder adds a fade to add naturalness to carousel-style transitions.
class _CustomTabBarViewCarouselBuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
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

/// Builders that have implemented the transitions used in Toss apps.
class _CustomTabBarViewToss1BuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
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

/// Builders that have implemented the transitions used in Toss apps.
class _CustomTabBarViewToss2BuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
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
