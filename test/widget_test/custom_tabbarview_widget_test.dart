import 'package:custom_tabbarview/custom_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../src/pages/home_page.dart';
import '../src/pages/page_1.dart';
import '../src/pages/page_2.dart';
import '../src/pages/page_3.dart';
import '../src/pages/page_4.dart';

void main() {
  // ========================================
  // MARK: animation
  // ========================================
  group('CustomTabBarView - animation', () {
    bool isHomePageInitialized = false;

    setUp(() {
      isHomePageInitialized = false;
    });

    testWidgets('default constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView(
            controller: controller,
            children: tabs,
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.animateTo(3, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.animateTo(1, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.animateTo(2, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });

    testWidgets('builder constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView.builder(
            controller: controller,
            tabs: tabs,
            builder: (context, pageController, childrenWithKey, index) {
              return childrenWithKey[index];
            },
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.animateTo(3, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.animateTo(1, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.animateTo(2, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });

    testWidgets('fade constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView.fade(
            controller: controller,
            tabs: tabs,
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.animateTo(3, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.animateTo(1, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.animateTo(2, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });

    testWidgets('stack constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView.stack(
            controller: controller,
            tabs: tabs,
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.animateTo(3, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.animateTo(1, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.animateTo(2, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });

    testWidgets('carousel constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView.carousel(
            controller: controller,
            tabs: tabs,
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.animateTo(3, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.animateTo(1, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.animateTo(2, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });

    testWidgets('toss1 constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView.toss1(
            controller: controller,
            tabs: tabs,
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.animateTo(3, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.animateTo(1, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.animateTo(2, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });

    testWidgets('toss2 constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView.toss2(
            controller: controller,
            tabs: tabs,
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.animateTo(3, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.animateTo(1, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.animateTo(2, duration: Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });
  });

  // ========================================
  // MARK: jump
  // ========================================
  group('CustomTabBarView - jump', () {
    bool isHomePageInitialized = false;

    setUp(() {
      isHomePageInitialized = false;
    });

    testWidgets('default constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView(
            controller: controller,
            children: tabs,
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.index = 3;
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.index = 1;
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.index = 2;
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });

    testWidgets('builder constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView.builder(
            controller: controller,
            tabs: tabs,
            builder: (context, pageController, childrenWithKey, index) {
              return childrenWithKey[index];
            },
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.index = 3;
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.index = 1;
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.index = 2;
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });

    testWidgets('fade constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView.fade(
            controller: controller,
            tabs: tabs,
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.index = 3;
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.index = 1;
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.index = 2;
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });

    testWidgets('stack constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView.stack(
            controller: controller,
            tabs: tabs,
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.index = 3;
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.index = 1;
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.index = 2;
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });

    testWidgets('carousel constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView.carousel(
            controller: controller,
            tabs: tabs,
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.index = 3;
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.index = 1;
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.index = 2;
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });

    testWidgets('toss1 constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView.toss1(
            controller: controller,
            tabs: tabs,
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.index = 3;
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.index = 1;
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.index = 2;
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });

    testWidgets('toss2 constructor renders children',
        (WidgetTester tester) async {
      List<Widget> tabs = [
        const Page1(),
        const Page2(),
        HomePage(
          onInit: () {
            isHomePageInitialized = true;
          },
        ),
        const Page3(),
        const Page4(),
      ];
      final controller = TabController(
        length: tabs.length,
        vsync: const TestVSync(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CustomTabBarView.toss2(
            controller: controller,
            tabs: tabs,
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      controller.index = 3;
      await tester.pumpAndSettle();
      expect(find.text('Page 3'), findsOneWidget);

      controller.index = 1;
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      expect(isHomePageInitialized, isFalse);

      controller.index = 2;
      await tester.pumpAndSettle();
      expect(find.text('Home Page 1 times built'), findsOneWidget);
      expect(isHomePageInitialized, isTrue);
    });
  });
}
