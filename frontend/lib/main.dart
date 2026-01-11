import 'package:flutter/material.dart';
import 'package:frontend/home.dart';
import 'package:provider/provider.dart';
import 'package:frontend/clip/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClipboardProvider()),
      ],
      child: MaterialApp(
        title: 'Deov.cn',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
