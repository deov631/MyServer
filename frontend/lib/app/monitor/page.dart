import 'package:flutter/material.dart';

class MonitorPage extends StatelessWidget {
  const MonitorPage({super.key});

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