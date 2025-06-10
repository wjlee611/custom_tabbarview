import 'dart:developer';

import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2>
    with AutomaticKeepAliveClientMixin<Page2> {
  @override
  void initState() {
    super.initState();
    log('init page 2');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      body: Center(child: Text('Page 2')),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
