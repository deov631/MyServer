import 'package:flutter/material.dart';

mixin ResponsiveLayout<T extends StatefulWidget> on State<T> {
  bool get isMobile => MediaQuery.of(context).size.width < MediaQuery.of(context).size.height;
  bool get isDesktop => !isMobile;

  Widget buildMobile(BuildContext context);
  Widget buildDesktop(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return isMobile ? buildMobile(context) : buildDesktop(context);
  }
}