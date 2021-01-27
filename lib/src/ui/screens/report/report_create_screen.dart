import 'package:capstone_mobile/src/ui/screens/report/report_form.dart';
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
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        // title: Text('Report create'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ReportForm(),
    );
  }
}
