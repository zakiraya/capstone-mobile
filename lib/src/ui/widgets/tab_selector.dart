import 'package:capstone_mobile/src/data/models/tab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;
  final List<Image> _icons = [
    Image.asset(
      "assets/home.png",
      height: 28,
    ),
    Image.asset(
      "assets/report.png",
      height: 28,
    ),
    Image.asset(
      "assets/violations.png",
      height: 28,
    ),
    Image.asset(
      "assets/Setting.png",
      height: 28,
    ),
  ];
  final List<String> _labels = [
    'Home',
    'Reports',
    'Violations',
    'Settings',
  ];

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: _icons[AppTab.values.indexOf(tab)],
          label: _labels[AppTab.values.indexOf(tab)],
        );
      }).toList(),
    );
  }
}
