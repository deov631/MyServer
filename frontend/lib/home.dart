import 'package:flutter/material.dart';
import 'package:frontend/clip/page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipboardPage(),
    );
  }
}