import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/blocs/tab/tab_bloc.dart';
import 'package:capstone_mobile/src/blocs/localization/localization_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_filter/violation_filter_bloc.dart';
import 'package:capstone_mobile/src/data/models/tab.dart';
import 'package:capstone_mobile/src/ui/screens/notification/notification_screen.dart';
import 'package:capstone_mobile/src/ui/screens/report/reports_screen.dart';
import 'package:capstone_mobile/src/ui/screens/settings_screen.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_create_screen.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_screen.dart';
import 'package:capstone_mobile/src/ui/widgets/tab_selector.dart';
import 'package:capstone_mobile/src/ui/widgets/violation/violation_list.dart';
import 'package:capstone_mobile/src/ui/widgets/report/report_list.dart';
import 'package:capstone_mobile/src/utils/utils.dart';
import 'package:capstone_mobile/generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      settings: RouteSettings(name: "/Home"),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ViolationFilterBloc(
              violationBloc: BlocProvider.of<ViolationBloc>(context),
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            ),
          ),
          BlocProvider(
            create: (context) => TabBloc(),
          ),
        ],
        child: BlocBuilder<LocalizationBloc, String>(
          builder: (context, state) {
            return HomeView();
          },
        ));
  }
}

class HomeView extends StatelessWidget {
  HomeView({
    Key key,
  }) : super(key: key);

  final List<Widget> _tabs = <Widget>[
    HomeTab(),
    ReportsTab(),
    ViolationTab(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: theme.scaffoldBackgroundColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  width: size.width * 0.07,
                  image: AssetImage('assets/logo.png'),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Column(
                  children: [
                    Image(
                      width: size.width * 0.2,
                      image: AssetImage('assets/brand_name.png'),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              Container(
                width: 64,
                child: Center(
                  child: Container(
                    width: 80,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () {
                        Utils.getImage();
                      },
                      child: Icon(Icons.camera_alt_outlined),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff916BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: activeTab == AppTab.violations
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          ViolationCreateScreen.route(),
                        );
                      },
                      child: Container(
                        width: 156,
                        height: 32,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            S
                                    .of(context)
                                    .VIOLATION_SCREEN_CREATE_NEW_BUTTON
                                    .toUpperCase() +
                                " +",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : null,
          body: _tabs[AppTab.values.indexOf(activeTab)],
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) => BlocProvider.of<TabBloc>(context).add(
              TabUpdated(tab),
            ),
          ),
        );
      },
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Container(
          width: size.width * 0.2,
          height: size.height * 0.2,
          color: Color(0xffE9EFFF),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: size.width * 0.2,
          height: size.height * 0.2,
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                      child: Text(
                        S.of(context).HOME_SEE_ALL,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, NotificationScreen.route());
                      },
                    ),
                  ],
                ),
                Divider(
                  height: 15,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ),
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
              padding: const EdgeInsets.all(8.0),
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
              padding: const EdgeInsets.all(8.0),
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
