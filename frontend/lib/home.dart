import 'package:flutter/material.dart';
import 'package:frontend/widget/responsive.dart';
import 'app/list/page.dart';
import 'app/home/page.dart';
import 'app/monitor/page.dart';
import 'app/settings/page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with MyResponsiveLayoutStatefulMixin {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _navItems = [
    {
      'icon': Icons.home,
      'title': '主页',
      'build': HomePage(),
    },
    {
      'icon': Icons.apps,
      'title': '应用',
      'build': ListPage(),
    },
    {
      'icon': Icons.monitor_heart,
      'title': '监控',
      'build': MonitorPage(),
    },
    {
      'icon': Icons.settings,
      'title': '设置',
      'build': SettingsPage(),
    },
  ];

  @override
  Widget buildDesktop(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
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
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: _navItems.map((item) => item['build'] as Widget).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    return Scaffold(
      body: const HomePage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onDestinationSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '主页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: '应用',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: '监控',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
      ),
    );
  }
  
  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}