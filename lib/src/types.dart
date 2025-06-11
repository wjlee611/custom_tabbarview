import 'package:flutter/material.dart';

/// {@template CustomTabBarViewCustomBuilder}
///
/// The type of custom builder method used globally in CustomTabBarView.
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
///
/// {@endtemplate}
typedef CustomTabBarViewCustomBuilder = Widget Function(
  BuildContext context,
  PageController pageController,
  List<Widget> childrenWithKey,
  int index,
);

/// {@template CustomTabBarViewBuilder}
///
/// The type of builder method used globally in CustomTabBarView.
///
/// It returns a Widget and takes the following arguments:
///
/// - [context]: [BuildContext] for the widget.
/// - [offset]: The offset value for each widget in the TabBarView.\
///   1: left / 0: center / -1: right
/// - [widget]: Each child widget of tabs.
///
/// {@endtemplate}
typedef CustomTabBarViewBuilder = Widget Function(
  BuildContext context,
  double offset,
  Widget child,
);

/// {@template CustomTabBarViewBuilderBaseDelegate}
///
/// Interface for delegate classes to handle builder functions* of
/// different interfaces.\
/// (* e.g. [CustomTabBarViewCustomBuilder], [CustomTabBarViewBuilder])
///
/// You can extend this interface to create delegates
/// that perform new behaviors or transformations.
///
/// For ease of implementation of the inheritance, a [getOffset] function
/// is predefined to compute the offset of each widget.
///
/// {@endtemplate}
abstract class CustomTabBarViewBuilderBaseDelegate {
  /// {@macro CustomTabBarViewBuilderBaseDelegate}
  const CustomTabBarViewBuilderBaseDelegate();

  /// As an internal behavior, package calls the build method to build.
  ///
  /// This means that you can transform the behavior of the build method
  /// by passing the appropriate builder to the constructor of the delegate.
  Widget build(
    BuildContext context,
    PageController pageController,
    List<Widget> childrenWithKey,
    int index,
  );

  /// Based on the PageController and the current index,
  /// calculate the offset value for the widget at that index.
  ///
  /// 1: left / 0: center / -1: right
  double calcOffset(PageController pageController, int index) {
    final page = pageController.page ?? pageController.initialPage.toDouble();
    return (page - index) * pageController.viewportFraction;
  }
}

/// {@template CustomTabBarViewCustomBuilderDelegate}
///
/// A delegate for more customization.
///
/// [CustomTabBarViewCustomBuilder] is used to build
///
/// {@endtemplate}
class CustomTabBarViewCustomBuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
  final CustomTabBarViewCustomBuilder builder;

  /// {@macro CustomTabBarViewCustomBuilderDelegate}
  const CustomTabBarViewCustomBuilderDelegate(this.builder);

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

/// {@template CustomTabBarViewBuilderDelegate}
///
/// A delegate for easy, free customization.
///
/// [CustomTabBarViewBuilder] is used to build
///
/// {@endtemplate}
class CustomTabBarViewBuilderDelegate
    extends CustomTabBarViewBuilderBaseDelegate {
  final CustomTabBarViewBuilder builder;

  /// {@macro CustomTabBarViewBuilderDelegate}
  const CustomTabBarViewBuilderDelegate(this.builder);

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
        final page =
            pageController.page ?? pageController.initialPage.toDouble();
        final offset = (page - index) * pageController.viewportFraction;
        return builder(
          context,
          offset,
          child ?? childrenWithKey[index],
        );
      },
      child: childrenWithKey[index],
    );
  }
}
