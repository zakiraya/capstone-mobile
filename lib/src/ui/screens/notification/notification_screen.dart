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
          leading: Icon(
            Icons.arrow_back_ios_outlined,
            color: theme.primaryColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Notifications',
                          style: TextStyle(
                              color: theme.primaryColor,
                              fontSize: theme.textTheme.headline1.fontSize),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.account_circle_outlined),
                        title: Text('Title......'),
                        subtitle: Text('Sub title'),
                        isThreeLine: true,
                        trailing: Icon(Icons.more_vert_outlined),
                        onTap: () {},
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
