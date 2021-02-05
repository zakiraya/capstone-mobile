import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => Test());
  }

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  int groupValue = 0;

  final Map<int, Widget> segments = <int, Widget>{
    0: Container(child: Text('Reports')),
    1: Container(child: Text('Drafts'))
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Container(
        child: CupertinoSegmentedControl(
          borderColor: Colors.orange,
          selectedColor: Colors.orange,
          groupValue: groupValue,
          children: segments,
          onValueChanged: (value) {
            setState(() {
              groupValue = value;
            });

            // context.read<ReportBloc>().add(const ReportRequested(
            //     token: "token",
            //     status: "fwaf" == 0 ? null : "drafts"));
          },
        ),
      ),
    );
  }
}
