import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

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
    String text = loremIpsum(words: 60);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        // title: Text('Report detail'),
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
      body: Padding(
        padding: EdgeInsets.only(left: 16, top: 8, right: 16),
        child: ListView(
          children: [
            Container(
              child: Text(
                'Report of 01213231',
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: theme.textTheme.headline5.fontSize,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("Created by: Lai Van Some"),
                ),
                Container(
                  child: Text("Status: "),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("Branch: "),
                  ),
                  Text('Kichi Kichi - Branch 01'),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: Text("Created on: "),
                  ),
                  Text('28/12/1998'),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: Text("Submitted on: "),
                  ),
                  Text('30/12/1998'),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: Text("Description: "),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("$text"),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Text("Violation list: "),
            ),
            SizedBox(
              height: 16,
            ),
            ViolationCard(),
            ViolationCard(),
            ViolationCard(),
            SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}

class ViolationCard extends StatelessWidget {
  const ViolationCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.purple[300],
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/avt.jpg'),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   width: 16,
              // ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("#error code"),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Violation name"),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Violator: Hoang Gia Bao",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Violated date: 28/12/1998",
                            style: TextStyle(fontSize: 8),
                          ),
                          Text("Status: Rejected",
                              style: TextStyle(fontSize: 8)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(
                Icons.edit_outlined,
                size: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
