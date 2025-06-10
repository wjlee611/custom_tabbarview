import 'package:custom_tabbarview/custom_tabbarview.dart';
import 'package:example/pages/home_page.dart';
import 'package:example/pages/page_1.dart';
import 'package:example/pages/page_2.dart';
import 'package:example/pages/page_3.dart';
import 'package:example/pages/page_4.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CustomTabBarView Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeTab(),
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget customBuilder(
    BuildContext context,
    PageController pageController,
    List<Widget> childrenWithKey,
    int index,
  ) {
    return KeyedSubtree(
      key: childrenWithKey[index].key,
      child: AnimatedBuilder(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomTabBarView Demo'),
      ),
      backgroundColor: Colors.white,
      body: CustomTabBarView.builder(
        controller: _tabController,
        physics: const PageScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        // children: [],
        tabs: [
          const HomePage(),
          const Page1(),
          const Page2(),
          const Page3(),
          const Page4(),
        ],
        builder: customBuilder,
      ),
      bottomNavigationBar: SafeArea(
        child: Transform.flip(
          flipY: true,
          child: SizedBox(
            height: 60,
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              labelColor: Theme.of(context).primaryColorDark,
              indicatorColor: Theme.of(context).primaryColorDark,
              labelStyle: const TextStyle(fontSize: 10),
              tabs: [
                Transform.flip(
                  flipY: true,
                  child: const Tab(icon: Icon(Icons.home), text: '홈'),
                ),
                Transform.flip(
                  flipY: true,
                  child: const Tab(icon: Icon(Icons.one_k), text: 'Page 1'),
                ),
                Transform.flip(
                  flipY: true,
                  child: const Tab(icon: Icon(Icons.two_k), text: 'Page 2'),
                ),
                Transform.flip(
                  flipY: true,
                  child: const Tab(icon: Icon(Icons.three_k), text: 'Page 3'),
                ),
                Transform.flip(
                  flipY: true,
                  child: const Tab(icon: Icon(Icons.four_k), text: 'Page 4'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
