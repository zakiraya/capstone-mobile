import 'package:capstone_mobile/generated/l10n.dart';
import 'package:capstone_mobile/src/blocs/notification/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:capstone_mobile/src/blocs/localization/localization_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({
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
            child: Text(
                S.of(context).NOTIFICATION + ' ' + S.of(context).LOAD_FAIL),
          ));
        } else if (state is NotificationLoadSuccess) {
          var notifications = state.notifications;

          if (notifications.isEmpty) {
            return Center(
              child: Text(
                  S.of(context).THERE_IS_NO + ' ' + S.of(context).NOTIFICATION),
            );
          }
          return Expanded(
            child: ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: notifications[index].isRead
                        ? Colors.grey[50]
                        : Colors.blue[50],
                    child: ListTile(
                      leading: Image.asset(
                        "assets/report.png",
                        height: 28,
                      ),
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
                      subtitle: Text(
                        ' ${DateFormat.yMMMd(BlocProvider.of<LocalizationBloc>(context).state).format(notifications[index].createdAt)} ',
                        style: TextStyle(fontSize: 12),
                      ),

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

class LatestNotificationList extends StatelessWidget {
  const LatestNotificationList({
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
          return Column(children: [
            Container(
              color: Colors.blue[50],
              child: ListTile(
                leading: Image.asset(
                  "assets/report.png",
                  height: 28,
                ),
                title: RichText(
                  text: TextSpan(
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      children: [
                        TextSpan(
                            text: ' ${state.notifications[0].description} '),
                        TextSpan(
                            text: '',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            )),
                      ]),
                ),
                subtitle: Text(
                  '1m ago',
                  style: TextStyle(fontSize: 12),
                ),

                // isThreeLine: true,
                onTap: () {},
              ),
            ),
            Container(
              color: Colors.blue[50],
              child: ListTile(
                leading: Image.asset(
                  "assets/report.png",
                  height: 28,
                ),
                title: RichText(
                  text: TextSpan(
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      children: [
                        TextSpan(
                            text: ' ${state.notifications[1].description} '),
                        TextSpan(
                            text: '',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            )),
                      ]),
                ),
                subtitle: Text(
                  '1m ago',
                  style: TextStyle(fontSize: 12),
                ),

                // isThreeLine: true,
                onTap: () {},
              ),
            ),
          ]);
        }
        return Center(
            child: Container(
          child: Text(''),
        ));
      },
    );
  }
}
