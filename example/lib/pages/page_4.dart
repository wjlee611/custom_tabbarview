import 'dart:developer';

import 'package:flutter/material.dart';

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4>
    with AutomaticKeepAliveClientMixin<Page4> {
  @override
  void initState() {
    super.initState();
    log('init page 4');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: Center(child: Text('Page 4')),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
