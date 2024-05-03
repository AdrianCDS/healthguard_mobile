import 'package:flutter/material.dart';
import 'package:healthguard_mobile/components/dashboard_activities.dart';
import 'package:healthguard_mobile/components/dashboard_alerts.dart';
import 'package:healthguard_mobile/components/dashboard_calendar.dart';
import 'package:healthguard_mobile/components/dashboard_home.dart';
import 'package:healthguard_mobile/components/dashboard_settings.dart';
import 'package:healthguard_mobile/components/dashboard_stats.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardNavigationBarState();
}

class _DashboardNavigationBarState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const DashboardHome(),
    const DashboardCalendar(),
    const DashboardStats(),
    const DashboardActivities(),
    const DashboardAlerts(),
    const DashboardSettings()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white70,
            ),
            child: _widgetOptions[_selectedIndex]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.white,
          elevation: 8,
          selectedItemColor: const Color.fromRGBO(28, 109, 241, 1),
          unselectedItemColor: const Color.fromRGBO(6, 40, 96, 1),
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_rounded), label: 'Calendar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_sharp), label: 'Stats'),
            BottomNavigationBarItem(
              icon: Icon(Icons.sticky_note_2),
              label: 'Activities',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Alerts'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
