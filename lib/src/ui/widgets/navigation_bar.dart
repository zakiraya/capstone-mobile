import 'package:flutter/material.dart';
import '../screens/report/reports_screen.dart';
import '../screens/cameras_screen.dart';
import '../screens/settings_screen.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({Key key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    ReportsScreen(),
    CamerasScreens(),
    SettingsScreen(),
  ];

  static List<String> _titles = ['Reports', 'Cameras', 'Settings'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = _titles[_selectedIndex];
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('$title'),
      //   centerTitle: true,
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: title,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.control_camera),
            label: title,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: title,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
