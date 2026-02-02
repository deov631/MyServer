import 'package:flutter/material.dart';
import 'package:frontend/widget/floating.dart';
import 'package:go_router/go_router.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

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
                context.push('/clip');
              },
            ),
          ],
        ),
      )
    );
  }
}