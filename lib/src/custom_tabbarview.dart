import 'package:custom_tabbarview/custom_tabbarview.dart';
import 'package:custom_tabbarview/src/custom_tabbarview_builders.dart';
import 'package:custom_tabbarview/src/custom_tabbarview_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum _EPreset { fade, stack, carousel }

class CustomTabBarView extends StatefulWidget {
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
  })  : _preset = null,
        builder = null;

  const CustomTabBarView.builder({
    super.key,
    List<Widget> tabs = const <Widget>[],
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
    required this.builder,
  })  : children = tabs,
        _preset = null;

  const CustomTabBarView.fade({
    super.key,
    List<Widget> tabs = const <Widget>[],
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
  })  : children = tabs,
        _preset = _EPreset.fade,
        builder = null;

  const CustomTabBarView.stack({
    super.key,
    List<Widget> tabs = const <Widget>[],
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
  })  : children = tabs,
        _preset = _EPreset.stack,
        builder = null;

  const CustomTabBarView.carousel({
    super.key,
    List<Widget> tabs = const <Widget>[],
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
  })  : children = tabs,
        _preset = _EPreset.carousel,
        builder = null;

  /// TODO: add description
  final _EPreset? _preset;

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

  /// TODO: add description
  final CustomTabBarViewBuilder? builder;

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
  State<CustomTabBarView> createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> {
  late final CustomTabBarViewBuilders _builders;
  CustomTabBarViewBuilder? _builder;

  @override
  void initState() {
    super.initState();
    _builders = CustomTabBarViewBuilders();
    _updateBuilder();
  }

  @override
  void didUpdateWidget(covariant CustomTabBarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._preset != oldWidget._preset ||
        widget.builder != oldWidget.builder) {
      setState(() {
        _updateBuilder();
      });
    }
  }

  void _updateBuilder() {
    switch (widget._preset) {
      case _EPreset.fade:
        _builder = _builders.fadeBuilder;
        break;
      case _EPreset.stack:
        _builder = _builders.stackBuilder;
        break;
      case _EPreset.carousel:
        _builder = _builders.carouselBuilder;
        break;
      default:
        _builder = widget.builder;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_builder == null) {
      return CustomTabBarViewCore(
        key: widget.key,
        children: widget.children,
        controller: widget.controller,
        physics: widget.physics,
        dragStartBehavior: widget.dragStartBehavior,
        viewportFraction: widget.viewportFraction,
        clipBehavior: widget.clipBehavior,
      );
    }

    return CustomTabBarViewCore.builder(
      key: widget.key,
      tabs: widget.children,
      controller: widget.controller,
      physics: widget.physics,
      dragStartBehavior: widget.dragStartBehavior,
      viewportFraction: widget.viewportFraction,
      clipBehavior: widget.clipBehavior,
      builder: _builder,
    );
  }
}
