import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:frontend/widget/floating.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/platform/web/web_nav.dart';

class HomeListPage extends StatelessWidget {
  const HomeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            MyFloatingCard(
              title: "Clipboard",
              titleStyle: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
              color1: Colors.redAccent,
              color2: Colors.red,
              onTap: () {
                if (kIsWeb) {
                  openInNewTab('/clip');
                } else {
                  context.push('/clip');
                }
              },
            ),
          ],
        ),
      )
    );
  }
}
