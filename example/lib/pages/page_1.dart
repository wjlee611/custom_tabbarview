import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1>
    with AutomaticKeepAliveClientMixin<Page1> {
  @override
  void initState() {
    super.initState();
    print('init page 1');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.yellow.shade300,
      body: Center(child: Text('Page 1')),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
