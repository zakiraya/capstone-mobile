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
              child: Column(
            children: [
              Container(
                child: Text(
                    S.of(context).NOTIFICATION + ' ' + S.of(context).LOAD_FAIL),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<NotificationBloc>(context)
                      .add(NotificationRequested());
                },
                child: Text(S.of(context).VIOLATION_SCREEN_RELOAD),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[200],
                  onPrimary: Colors.black,
                ),
              ),
            ],
          ));
        } else if (state is NotificationLoadSuccess) {
          var notifications = state.notifications.reversed.toList();
          if (notifications.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Text(S.of(context).THERE_IS_NO +
                      ' ' +
                      S.of(context).NOTIFICATION),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<NotificationBloc>(context)
                          .add(NotificationRequested());
                    },
                    child: Text(S.of(context).VIOLATION_SCREEN_RELOAD),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[200],
                      onPrimary: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          }
          return Expanded(
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (scrollEnd) {
                var metrics = scrollEnd.metrics;
                if (metrics.atEdge) {
                  if (metrics.pixels == 0) {
                    BlocProvider.of<NotificationBloc>(context)
                        .add(NotificationRequested());
                  } else {
                    BlocProvider.of<NotificationBloc>(context)
                        .add(NotificationRequested());
                  }
                }
                return true;
              },
              child: ListView.builder(
                  itemCount: notifications.length,
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
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Text(
                                  ' ${DateFormat.yMMMd(BlocProvider.of<LocalizationBloc>(context).state).format(notifications[index].createdAt)} ',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: ' ${notifications[index].name} '),
                                    TextSpan(
                                        text: '',
                                        style: TextStyle(
                                          color: Color(0xffF3F2FF),
                                          decoration: TextDecoration.underline,
                                        )),
                                  ]),
                            ),
                          ],
                        ),
                        // subtitle: Text(
                        //   ' ${DateFormat.yMMMd(BlocProvider.of<LocalizationBloc>(context).state).format(notifications[index].createdAt)} ',
                        //   style: TextStyle(fontSize: 12),
                        // ),
                        subtitle: Text(notifications[index].description),
                        isThreeLine: true,

                        onTap: () {
                          if (!notifications[index].isRead) {
                            BlocProvider.of<NotificationBloc>(context).add(
                                NotificationIsRead(
                                    id: notifications[index].id));
                          }
                        },
                      ),
                    );
                  }),
            ),
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
              child: Column(
            children: [
              Container(
                child: Text(S.of(context).THERE_IS_NO +
                    ' ' +
                    S.of(context).NOTIFICATION),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<NotificationBloc>(context)
                      .add(NotificationRequested());
                },
                child: Text(S.of(context).VIOLATION_SCREEN_RELOAD),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[200],
                  onPrimary: Colors.black,
                ),
              ),
            ],
          ));
        } else if (state is NotificationLoadSuccess) {
          var notifications = state.notifications.reversed.toList();

          if (notifications.isEmpty) {
            return Center(
              child: Text('there is no notifications'),
            );
          }
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: notifications.length > 1 ? 2 : 1,
            itemBuilder: (context, index) {
              return Container(
                color:
                    notifications[0].isRead ? Colors.grey[50] : Colors.blue[50],
                child: ListTile(
                  leading: Image.asset(
                    "assets/report.png",
                    height: 28,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Text(
                            ' ${DateFormat.yMMMd(BlocProvider.of<LocalizationBloc>(context).state).format(notifications[index].createdAt)} ',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            children: [
                              TextSpan(text: '${notifications[index].name}'),
                              TextSpan(
                                  text: '',
                                  style: TextStyle(
                                    color: Color(0xffF3F2FF),
                                    decoration: TextDecoration.underline,
                                  )),
                            ]),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    ' ${notifications[index].description} ',
                    style: TextStyle(fontSize: 12),
                  ),

                  // isThreeLine: true,
                  onTap: () {},
                ),
              );
            },
          );
        }
        return Center(
            child: Container(
          child: Text(''),
        ));
      },
    );
  }
}
