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

class _MyHomePageState extends State<MyHomePage> with ResponsiveLayout {
  int _selectedIndex = 0;

  @override
  Widget buildDesktop(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.apps),
                  label: Text('Applications'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.monitor_heart),
                  label: Text('Monitor'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text('Settings'),
                ),
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  _buildHomePage(context),
                  _buildListPage(context),
                  _buildMonitorPage(context),
                  _buildSettingsPage(context),
                ],
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
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/page2');
          },
          child: const Text('Go to page 2'),
        ),
      ),
    );
  }
  
  Widget _buildHomePage(BuildContext context) {
    return HomePage();
  }
  
  Widget _buildListPage(BuildContext context) {
    return ListPage();
  }
  
  Widget _buildMonitorPage(BuildContext context) {
    return MonitorPage();
  }
  
  Widget _buildSettingsPage(BuildContext context) {
    return SettingsPage();
  }
}