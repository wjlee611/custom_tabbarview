import 'package:flutter/material.dart';

typedef CustomTabBarViewBuilder = Widget Function(
  BuildContext context,
  PageController pageController,
  List<Widget> childrenWithKey,
  int index,
);
