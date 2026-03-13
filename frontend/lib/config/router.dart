import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:frontend/app/clip/page.dart';
import 'package:frontend/app/home/page.dart';
import 'package:frontend/app/init/page.dart';
import 'package:frontend/app/home/home/page.dart';
import 'package:frontend/app/home/list/page.dart';
import 'package:frontend/app/home/monitor/page.dart';
import 'package:frontend/app/home/settings/page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final homeLayoutNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter globalRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/init',
      builder: (context, state) => const InitPage(),
    ),
    ShellRoute(
      parentNavigatorKey: rootNavigatorKey,
      navigatorKey: homeLayoutNavigatorKey,
      builder: (context, state, child) => HomeLayoutPage(state: state, child: child,),
      routes: [
        GoRoute(
          parentNavigatorKey: homeLayoutNavigatorKey,
          path: '/home',
          builder: (context, state) => const HomeMainPage(),
        ),
        GoRoute(
          parentNavigatorKey: homeLayoutNavigatorKey,
          path: '/list',
          builder: (context, state) => const HomeListPage(),
        ),
        GoRoute(
          parentNavigatorKey: homeLayoutNavigatorKey,
          path: '/monitor',
          builder: (context, state) => const HomeMonitorPage(),
        ),
        GoRoute(
          parentNavigatorKey: homeLayoutNavigatorKey,
          path: '/settings',
          builder: (context, state) => const HomeSettingsPage(),
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/clip',
      builder: (context, state) => const ClipboardPage(),
    )
  ],
  initialLocation: '/home',
);