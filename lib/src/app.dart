import 'package:flutter/material.dart';
import 'ui/widgets/navigation_bar.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to flutter',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.blue,
      ),
      home: NavigationBar(),
    );
  }
}
