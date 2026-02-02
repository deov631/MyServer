import 'package:frontend/app/clip/page.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/app/home/page.dart';
import 'package:frontend/app/list/page.dart';
import 'package:frontend/app/monitor/page.dart';
import 'package:frontend/app/settings/page.dart';
import 'package:frontend/home.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const MyHomePage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home_page',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/list',
      name: 'list',
      builder: (context, state) => const ListPage(),
    ),
    GoRoute(
      path: '/monitor',
      name: 'monitor',
      builder: (context, state) => const MonitorPage(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/clip',
      name: 'clip',
      builder: (context, state) => const ClipboardPage(),
    )
  ],
  initialLocation: '/',
);