import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/app/clip/provider.dart';
import 'package:frontend/config/router.dart';

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
      child: MaterialApp.router(
        title: 'deov.cn',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        ),
        routerConfig: globalRouter,
      ),
    );
  }
}
