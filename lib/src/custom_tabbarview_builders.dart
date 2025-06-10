import 'package:custom_tabbarview/custom_tabbarview.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomTabBarViewBuilders {
  /// 1(left) \~ 0(center) \~ -1(right)
  static double _calculateOffset(int index, PageController pageController) {
    double page = 0.0;
    page = pageController.page ?? pageController.initialPage.toDouble();
    return (page - index) * pageController.viewportFraction;
  }

  // ========================================
  // MARK: fadeBuilder
  // ========================================
  CustomTabBarViewBuilder fadeBuilder =
      (context, pageController, childrenWithKey, index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        final offset = _calculateOffset(index, pageController);

        final opacity = 1 - offset.abs() * 2;

        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: child,
        );
      },
      child: childrenWithKey[index],
    );
  };

  // ========================================
  // MARK: stackBuilder
  // ========================================
  CustomTabBarViewBuilder stackBuilder =
      (context, pageController, childrenWithKey, index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        final width = MediaQuery.sizeOf(context).width;
        final offset = _calculateOffset(index, pageController);

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
  };

  // ========================================
  // MARK: carouselBuilder
  // ========================================
  CustomTabBarViewBuilder carouselBuilder =
      (context, pageController, childrenWithKey, index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        final width = MediaQuery.sizeOf(context).width;
        final offset = _calculateOffset(index, pageController);

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
  };

  // ========================================
  // MARK: toss1Builder
  // ========================================
  CustomTabBarViewBuilder toss1Builder =
      (context, pageController, childrenWithKey, index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        final width = MediaQuery.sizeOf(context).width;
        final offset = _calculateOffset(index, pageController);

        final dx = offset * width * 0.95;
        final opacity = 1 - offset.abs() * 1.2;

        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.translate(offset: Offset(dx, 0), child: child),
        );
      },
      child: childrenWithKey[index],
    );
  };

  // ========================================
  // MARK: toss2Builder
  // ========================================
  CustomTabBarViewBuilder toss2Builder =
      (context, pageController, childrenWithKey, index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        final offset = _calculateOffset(index, pageController);

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
  };
}
