import 'package:flutter/material.dart';

class CreateReportScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CreateReportScreen());
  }

  @override
  _CreateReportScreenState createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create report'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Text('test'),
      ),
    );
  }
}
