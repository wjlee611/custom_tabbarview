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
  final List<Widget> _children = [
    const HomePage(),
    const Page1(),
    const Page2(),
    const Page3(),
    const Page4(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _children.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomTabBarView Demo'),
      ),
      backgroundColor: Colors.white,
      body: CustomTabBarView.custom(
        controller: _tabController,
        physics: const PageScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        tabs: _children,
        builderDelegate: CustomTabBarViewCustomBuilderDelegate(
          (context, pageController, childrenWithKey, index) {
            return AnimatedBuilder(
              animation: pageController,
              builder: (context, child) {
                final page = pageController.page ??
                    pageController.initialPage.toDouble();
                final offset = (page - index) * pageController.viewportFraction;

                final dx = offset * width * 0.8;
                final scale = 1 - offset.abs() * 0.1;
                final opacity = 1 - offset.abs() * 2;

                return Opacity(
                  opacity: opacity.clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: scale,
                    child: Transform.translate(
                        offset: Offset(dx, 0), child: child),
                  ),
                );
              },
              child: childrenWithKey[index],
            );
          },
        ),
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
