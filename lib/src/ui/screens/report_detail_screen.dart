import 'package:flutter/material.dart';

class ReportDetailScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ReportDetailScreen());
  }

  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Report detail'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                child: Text(
                  'Report title',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: theme.textTheme.headline1.fontSize),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("Branch: "),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text("Created by: "),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text("Created on: "),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text("Description: "),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    maxLines: 8,
                    decoration: InputDecoration.collapsed(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(new Radius.circular(5.0))),
                        hintText: "Enter your text here"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(context, ChangePasswordScreen.route());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'List violations',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.red,
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
