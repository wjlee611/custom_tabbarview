import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  int _buildCount = 0;

  @override
  void initState() {
    super.initState();
    print('init home page');
    _buildCount++;
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
