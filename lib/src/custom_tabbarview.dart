import 'package:custom_tabbarview/custom_tabbarview.dart';
import 'package:custom_tabbarview/src/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

part '_builder_presets.dart';

/// This is a new API derived from TabBarView.
///
/// The basic usage is almost identical to TabBarView,
/// and the migration guide is as follows:
///
/// - Rename [chindren] to [tabs].
/// - Implement [builder] type of [CustomTabBarViewBuilder].
class CustomTabBarView extends StatelessWidget {
  /// Creates a page view with one child per tab.
  ///
  /// The length of [children] must be the same as the [controller]'s length.
  const CustomTabBarView({
    super.key,
    required this.children,
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
  }) : builderDelegate = null;

  /// This is a new API derived from TabBarView.
  ///
  /// The basic usage is almost identical to TabBarView,
  /// and the migration guide is as follows:
  ///
  /// - Rename [chindren] to [tabs].
  /// - Implement [builder] type of [CustomTabBarViewBuilder].
  CustomTabBarView.builder({
    super.key,
    List<Widget> tabs = const <Widget>[],
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
    required CustomTabBarViewSimpleBuilder builder,
  })  : children = tabs,
        builderDelegate = CustomTabBarViewSimpleBuilderDelegate(builder);

  const CustomTabBarView.custom({
    super.key,
    List<Widget> tabs = const <Widget>[],
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
    required this.builderDelegate,
  }) : children = tabs;

  /// This is a new API derived from TabBarView.
  ///
  /// Constructor with a **fade** transition animation.
  ///
  /// The basic usage is almost identical to TabBarView,
  /// and the migration guide is as follows:
  ///
  /// - Rename [chindren] to [tabs].
  CustomTabBarView.fade({
    super.key,
    List<Widget> tabs = const <Widget>[],
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
  })  : children = tabs,
        builderDelegate = CustomTabBarViewCustomBuilderDelegate(
          CustomTabBarViewBuilders().fadeBuilder,
        );

  /// This is a new API derived from TabBarView.
  ///
  /// Constructor with a **stack** transition animation.
  ///
  /// The basic usage is almost identical to TabBarView,
  /// and the migration guide is as follows:
  ///
  /// - Rename [chindren] to [tabs].
  CustomTabBarView.stack({
    super.key,
    List<Widget> tabs = const <Widget>[],
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
  })  : children = tabs,
        builderDelegate = CustomTabBarViewCustomBuilderDelegate(
          CustomTabBarViewBuilders().stackBuilder,
        );

  /// This is a new API derived from TabBarView.
  ///
  /// Constructor with a **carousel** transition animation.
  ///
  /// The basic usage is almost identical to TabBarView,
  /// and the migration guide is as follows:
  ///
  /// - Rename [chindren] to [tabs].
  CustomTabBarView.carousel({
    super.key,
    List<Widget> tabs = const <Widget>[],
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
  })  : children = tabs,
        builderDelegate = CustomTabBarViewCustomBuilderDelegate(
          CustomTabBarViewBuilders().carouselBuilder,
        );

  /// This is a new API derived from TabBarView.
  ///
  /// Constructor with a **Toss app** transition animation.
  ///
  /// The basic usage is almost identical to TabBarView,
  /// and the migration guide is as follows:
  ///
  /// - Rename [chindren] to [tabs].
  CustomTabBarView.toss1({
    super.key,
    List<Widget> tabs = const <Widget>[],
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
  })  : children = tabs,
        builderDelegate = CustomTabBarViewCustomBuilderDelegate(
          CustomTabBarViewBuilders().toss1Builder,
        );

  /// This is a new API derived from TabBarView.
  ///
  /// Constructor with a **Toss app** transition animation.
  ///
  /// The basic usage is almost identical to TabBarView,
  /// and the migration guide is as follows:
  ///
  /// - Rename [chindren] to [tabs].
  CustomTabBarView.toss2({
    super.key,
    List<Widget> tabs = const <Widget>[],
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
  })  : children = tabs,
        builderDelegate = CustomTabBarViewCustomBuilderDelegate(
          CustomTabBarViewBuilders().toss2Builder,
        );

  /// This widget's selection and animation state.
  ///
  /// If [TabController] is not provided, then the value of [DefaultTabController.of]
  /// will be used.
  final TabController? controller;

  /// One widget per tab.
  ///
  /// Its length must match the length of the [TabBar.tabs]
  /// list, as well as the [controller]'s [TabController.length].
  final List<Widget> children;

  /// The builder for building the widgets passed in [tabs] individually.
  ///
  /// It must be implemented as a [CustomTabBarViewBuilder] type.
  final CustomTabBarViewBuilderDelegate? builderDelegate;

  /// How the page view should respond to user input.
  ///
  /// For example, determines how the page view continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.widgets.pageview.viewportFraction}
  final double viewportFraction;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    if (builderDelegate == null) {
      return CustomTabBarViewCore(
        key: key,
        children: children,
        controller: controller,
        physics: physics,
        dragStartBehavior: dragStartBehavior,
        viewportFraction: viewportFraction,
        clipBehavior: clipBehavior,
      );
    }

    return CustomTabBarViewCore.custom(
      key: key,
      tabs: children,
      controller: controller,
      physics: physics,
      dragStartBehavior: dragStartBehavior,
      viewportFraction: viewportFraction,
      clipBehavior: clipBehavior,
      builderDelegate: builderDelegate,
    );
  }
}
