import 'package:custom_tabbarview/custom_tabbarview.dart';
import 'package:flutter/material.dart';

class CustomTabBarViewBuilders {
  // ========================================
  // MARK: carouselBuilder
  // ========================================
  CustomTabBarViewBuilder carouselBuilder = (context, pageController,
          childrenWithKey, index) =>
      AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          double page = 0.0;
          try {
            page = pageController.page ?? pageController.initialPage.toDouble();
          } catch (_) {
            page = pageController.initialPage.toDouble();
          }
          double offset = page - index;
          // Custom animation: outgoing page moves 0~20% and fades out,
          // incoming page moves 80~100% and fades in.
          double dx = 0.0;
          double opacity = 1.0;
          final width = MediaQuery.of(context).size.width;

          // Outgoing page (current)
          if (offset > 0 && offset <= 1) {
            // Swiping right, this page is outgoing
            if (offset > 0.5) {
              // 0.5~1.0: move 80%~100%, opacity 0~1
              double t = (offset - 0.5) / 0.5;
              dx = (0.6 + t * 0.4) * width;
              opacity = t;
            } else {
              // 0~0.5: move stays at 80%, opacity 0
              dx = 0.6 * width;
              opacity = 0.0;
            }
          } else if (offset < 0 && offset >= -1) {
            // Swiping left, this page is outgoing
            if (offset < -0.5) {
              // -0.5~-1.0: move -80%~-100%, opacity 0~1
              double t = (-offset - 0.5) / 0.5;
              dx = -(0.6 + t * 0.4) * width;
              opacity = t;
            } else {
              // 0~ -0.5: move stays at -80%, opacity 0
              dx = -0.6 * width;
              opacity = 0.0;
            }
          } else if (offset == 0) {
            dx = 0;
            opacity = 1.0;
          }

          // Incoming page
          if (offset > 0 && offset <= 1) {
            // This page is incoming from left
            if (offset <= 0.5) {
              // 0~0.5: move 0~20%, fade 1~0
              double t = offset / 0.5;
              dx = t * 0.4 * width;
              opacity = 1.0 - t;
            } else {
              // 0.5~1.0: move stays at 20%, opacity 0
              dx = 0.4 * width;
              opacity = 0.0;
            }
          } else if (offset < 0 && offset >= -1) {
            // This page is incoming from right
            if (offset >= -0.5) {
              // 0~ -0.5: move 0~ -20%, fade 1~0
              double t = -offset / 0.5;
              dx = -t * 0.4 * width;
              opacity = 1.0 - t;
            } else {
              // -0.5~ -1.0: move stays at -20%, opacity 0
              dx = -0.4 * width;
              opacity = 0.0;
            }
          }
          return Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: offset.abs() < 1 ? 1 - offset.abs() * 0.1 : 0.8,
              child: Transform.translate(offset: Offset(dx, 0), child: child),
            ),
          );
        },
        child: childrenWithKey[index],
      );

  // ========================================
  // MARK: fadeBuilder
  // ========================================
  CustomTabBarViewBuilder fadeBuilder = (context, pageController,
          childrenWithKey, index) =>
      AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          double page = 0.0;
          try {
            page = pageController.page ?? pageController.initialPage.toDouble();
          } catch (_) {
            page = pageController.initialPage.toDouble();
          }
          double offset = page - index;
          double opacity = 1.0;

          // Outgoing page (current)
          if (offset > 0 && offset <= 1) {
            if (offset > 0.5) {
              double t = (offset - 0.5) / 0.5;
              opacity = t;
            } else {
              opacity = 0.0;
            }
          } else if (offset < 0 && offset >= -1) {
            if (offset < -0.5) {
              double t = (-offset - 0.5) / 0.5;
              opacity = t;
            } else {
              opacity = 0.0;
            }
          } else if (offset == 0) {
            opacity = 1.0;
          }

          // Incoming page
          if (offset > 0 && offset <= 1) {
            if (offset <= 0.5) {
              double t = offset / 0.5;
              opacity = 1.0 - t;
            } else {
              opacity = 0.0;
            }
          } else if (offset < 0 && offset >= -1) {
            if (offset >= -0.5) {
              double t = -offset / 0.5;
              opacity = 1.0 - t;
            } else {
              opacity = 0.0;
            }
          }
          return Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: child,
          );
        },
        child: childrenWithKey[index],
      );

  // ========================================
  // MARK: stackBuilder
  // ========================================
  CustomTabBarViewBuilder stackBuilder = (context, pageController,
          childrenWithKey, index) =>
      AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          double page = 0.0;
          try {
            page = pageController.page ?? pageController.initialPage.toDouble();
          } catch (_) {
            page = pageController.initialPage.toDouble();
          }
          double offset = page - index;
          // Custom animation: outgoing page moves 0~20% and fades out,
          // incoming page moves 80~100% and fades in.
          double dx = 0.0;
          double opacity = 1.0;
          final width = MediaQuery.of(context).size.width;

          // Outgoing page (current)
          if (offset > 0 && offset <= 1) {
            // Swiping right, this page is outgoing
            if (offset > 0.5) {
              // 0.5~1.0: move 80%~100%, opacity 0~1
              double t = (offset - 0.5) / 0.5;
              dx = (0.6 + t * 0.4) * width;
              opacity = t;
            } else {
              // 0~0.5: move stays at 80%, opacity 0
              dx = 0.6 * width;
              opacity = 0.0;
            }
          } else if (offset < 0 && offset >= -1) {
            // Swiping left, this page is outgoing
            if (offset < -0.5) {
              // -0.5~-1.0: move -80%~-100%, opacity 0~1
              double t = (-offset - 0.5) / 0.5;
              dx = -(0.6 + t * 0.4) * width;
              opacity = t;
            } else {
              // 0~ -0.5: move stays at -80%, opacity 0
              dx = -0.6 * width;
              opacity = 0.0;
            }
          } else if (offset == 0) {
            dx = 0;
            opacity = 1.0;
          }

          // Incoming page
          if (offset > 0 && offset <= 1) {
            // This page is incoming from left
            if (offset <= 0.5) {
              // 0~0.5: move 0~20%, fade 1~0
              double t = offset / 0.5;
              dx = t * 0.4 * width;
              opacity = 1.0 - t;
            } else {
              // 0.5~1.0: move stays at 20%, opacity 0
              dx = 0.4 * width;
              opacity = 0.0;
            }
          } else if (offset < 0 && offset >= -1) {
            // This page is incoming from right
            if (offset >= -0.5) {
              // 0~ -0.5: move 0~ -20%, fade 1~0
              double t = -offset / 0.5;
              dx = -t * 0.4 * width;
              opacity = 1.0 - t;
            } else {
              // -0.5~ -1.0: move stays at -20%, opacity 0
              dx = -0.4 * width;
              opacity = 0.0;
            }
          }

          double dxNorm = 1.0 - (dx / width);

          return Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: dxNorm,
              child: Transform.translate(
                  offset: Offset(dx > 0 ? dx : -dx, 0), child: child),
            ),
          );
        },
        child: childrenWithKey[index],
      );
}
