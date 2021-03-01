import 'package:capstone_mobile/src/data/models/tab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;
  final List<Icon> _icons = [
    Icon(Icons.home),
    Icon(Icons.article_outlined),
    Icon(Icons.article_outlined),
    Icon(Icons.settings),
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
