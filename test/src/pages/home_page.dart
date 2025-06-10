import 'dart:developer';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Function() onInit;

  const HomePage({super.key, required this.onInit});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  int _buildCount = 0;

  @override
  void initState() {
    super.initState();
    log('init home page');
    _buildCount++;
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.red.shade300,
      body: Center(child: Text('Home Page $_buildCount times built')),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
