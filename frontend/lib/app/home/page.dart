import 'package:flutter/material.dart';
import 'package:frontend/widget/responsive.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'monitor/provider.dart' show HealthMonitorProvider;

class HomeLayoutPage extends StatefulWidget {
  final GoRouterState state;
  final Widget child;

  const HomeLayoutPage({super.key, required this.state, required this.child});

  @override
  State<StatefulWidget> createState() => _HomeLayoutPageState();
}

class _HomeLayoutPageState extends State<HomeLayoutPage> with MyResponsiveLayoutStatefulMixin {
  int get _selectedIndex {
    final location = widget.state.uri.path;
    for (int i = 0; i < _navItems.length; i++) {
      if (_navItems[i]['route'] == location) {
        return i;
      }
    }
    return 0;
  }

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home, 'title': '主页', 'route': '/home'},
    {'icon': Icons.apps, 'title': '应用', 'route': '/list'},
    {'icon': Icons.monitor_heart, 'title': '监控', 'route': '/monitor'},
    {'icon': Icons.settings, 'title': '设置', 'route': '/settings'},
  ];

  @override
  Widget buildDesktop(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 80,
            child: NavigationRail(
              selectedIndex: _selectedIndex,
              groupAlignment: 0.0,
              labelType: NavigationRailLabelType.selected,
              onDestinationSelected: _onDestinationSelected,
              destinations: [
                ...List.generate(
                  _navItems.length,
                  (index) => NavigationRailDestination(
                    icon: Icon(_navItems[index]['icon']),
                    label: Text(_navItems[index]['title']),
                  ),
                ),
              ],
            ),
          ),
          buildChild(context),
        ],
      ),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    return Scaffold(
      body: buildChild(context),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onDestinationSelected,
        items: [
          ...List.generate(
            _navItems.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(_navItems[index]['icon']),
              label: _navItems[index]['title'],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChild(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HealthMonitorProvider()),
      ],
      child: Expanded(child: widget.child),
    );
  }

  void _onDestinationSelected(int index) {
    _navigateTo(_navItems[index]['route']);
  }

  void _navigateTo(String route) {
    context.go(route);
  }
}
