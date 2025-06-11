import 'package:flutter/material.dart';

/// The type of builder method used globally in CustomTabBarView.
///
/// It returns a Widget and takes the following arguments:
///
/// - [context]: [BuildContext] for the widget.
/// - [pageController]: A [PageController] for PageView that internally
/// implements TabBarView.
/// - [childrenWithKey]: The children or tabs passed in.\
///   However, the implementation of TabBarView temporarily
///   changes the order of the child widgets on transition.
/// - [index]: The index of the widget currently being displayed
///   in the TabBarView.
///
/// **Important**
///
/// You can get the child that match the TabController
/// with `childrenWithKey[index]`.
typedef CustomTabBarViewCustomBuilder = Widget Function(
  BuildContext context,
  PageController pageController,
  List<Widget> childrenWithKey,
  int index,
);

typedef CustomTabBarViewBuilder = Widget Function(
  BuildContext context,
  double offset,
  Widget child,
);

abstract class CustomTabBarViewBuilderBaseDelegate {
  Widget build(
    BuildContext context,
    PageController pageController,
    List<Widget> childrenWithKey,
    int index,
  );

  double offset(PageController pageController, int index) {
    final page = pageController.page ?? pageController.initialPage.toDouble();
    return (page - index) * pageController.viewportFraction;
  }
}

class CustomTabBarViewCustomBuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
  final CustomTabBarViewCustomBuilder builder;

  CustomTabBarViewCustomBuilderDelegate(this.builder);

  @override
  Widget build(
    BuildContext context,
    PageController pageController,
    List<Widget> childrenWithKey,
    int index,
  ) {
    return builder(context, pageController, childrenWithKey, index);
  }
}

class CustomTabBarViewBuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
  final CustomTabBarViewBuilder builder;

  CustomTabBarViewBuilderDelegate(this.builder);

  @override
  Widget build(
    BuildContext context,
    PageController pageController,
    List<Widget> childrenWithKey,
    int index,
  ) {
    return builder(
      context,
      offset(pageController, index),
      childrenWithKey[index],
    );
  }
}
