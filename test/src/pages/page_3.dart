import 'dart:developer';

import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3>
    with AutomaticKeepAliveClientMixin<Page3> {
  @override
  void initState() {
    super.initState();
    log('init page 3');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Center(child: Text('Page 3')),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
