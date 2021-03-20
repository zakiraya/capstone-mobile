import 'package:capstone_mobile/generated/l10n.dart';
import 'package:capstone_mobile/src/blocs/tab/tab_bloc.dart';
import 'package:capstone_mobile/src/data/models/tab.dart';
import 'package:capstone_mobile/src/ui/screens/notification/notification_screen.dart';
import 'package:capstone_mobile/src/ui/widgets/notification/notification_list.dart';
import 'package:capstone_mobile/src/ui/widgets/report/report_list.dart';
import 'package:capstone_mobile/src/ui/widgets/violation/violation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Container(
          width: size.width * 0.2,
          height: size.height * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/cover.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: size.width * 0.2,
          // height: size.height * 0.1,
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).HOME_LATEST_NOTIFICATION,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        child: Text(
                          S.of(context).HOME_SEE_ALL,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, NotificationScreen.route());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        LatestNotificationList(),
        SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<TabBloc>(context).add(
              TabUpdated(AppTab.reports),
            );
          },
          child: Container(
            color: Colors.orange[400],
            height: 36,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).HOME_REPORT_LIST,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
        LatestReportList(),
        SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<TabBloc>(context).add(
              TabUpdated(AppTab.violations),
            );
          },
          child: Container(
            color: Colors.orange[400],
            height: 36,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).HOME_VIOLATION_LIST,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
        LatesViolationList(),
      ],
    );
  }
}
