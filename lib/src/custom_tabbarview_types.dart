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
typedef CustomTabBarViewBuilder = Widget Function(
  BuildContext context,
  PageController pageController,
  List<Widget> childrenWithKey,
  int index,
);
