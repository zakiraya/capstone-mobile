import 'package:capstone_mobile/src/blocs/notification/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:capstone_mobile/src/blocs/localization/localization_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<LocalizationBloc, String>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: theme.scaffoldBackgroundColor,
              leading: IconButton(
                iconSize: 16.0,
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
                  _NotificationList(),
                ],
              ),
            ));
      },
    );
  }
}

class _NotificationList extends StatelessWidget {
  const _NotificationList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NotificationLoadFailure) {
          return Center(
              child: Container(
            child: Text('Notification load fail'),
          ));
        } else if (state is NotificationLoadSuccess) {
          var notifications = state.notifications;

          if (notifications.isEmpty) {
            return Center(
              child: Text('there is no notifications'),
            );
          }
          return Expanded(
            child: ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Color(0xffF3F2FF),
                    child: ListTile(
                      leading: Icon(Icons.notifications),
                      title: RichText(
                        text: TextSpan(
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            children: [
                              TextSpan(
                                  text:
                                      ' ${notifications[index].description} '),
                              TextSpan(
                                  text: '',
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
          );
        }
        return Center(
            child: Container(
          child: Text('hello'),
        ));
      },
    );
  }
}
