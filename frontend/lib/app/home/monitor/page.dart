import 'package:flutter/material.dart';

class HomeMonitorPage extends StatelessWidget {
  const HomeMonitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monitor'),
      ),
      body: Center(
        child: Text('Monitor Page'),
      ),
    );
  }
}