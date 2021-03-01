import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NotificationScreen());
  }

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: theme.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              Container(
                color: Colors.grey[100],
                width: double.infinity,
                child: Text(
                  'Latest notifications',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey[200],
                        child: ListTile(
                          leading: Icon(Icons.account_circle_outlined),
                          title: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                children: [
                                  TextSpan(
                                      text:
                                          'Your violation you posted on 02/02/2021 has been done.'),
                                  TextSpan(
                                      text: 'Check now.',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      )),
                                ]),
                          ),
                          subtitle: Text('1m ago'),

                          // isThreeLine: true,
                          onTap: () {},
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
