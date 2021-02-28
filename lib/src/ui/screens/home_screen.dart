import 'package:capstone_mobile/src/blocs/tab/tab_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_filter/violation_filter_bloc.dart';
import 'package:capstone_mobile/src/data/models/tab.dart';
import 'package:capstone_mobile/src/ui/screens/report/reports_screen.dart';
import 'package:capstone_mobile/src/ui/screens/settings_screen.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_create_screen.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_screen.dart';
import 'package:capstone_mobile/src/ui/widgets/navigation_bar.dart';
import 'package:capstone_mobile/src/ui/widgets/tab_selector.dart';
import 'package:capstone_mobile/src/ui/widgets/violation/violation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      settings: RouteSettings(name: "/Home"),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ViolationFilterBloc(
          violationBloc: BlocProvider.of<ViolationBloc>(context),
        ),
      ),
      BlocProvider(
        create: (context) => TabBloc(),
      ),
    ], child: HomeView());
  }
}

class HomeView extends StatelessWidget {
  HomeView({
    Key key,
  }) : super(key: key);

  List<Widget> _tabs = <Widget>[
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
            backgroundColor: theme.scaffoldBackgroundColor,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  width: size.width * 0.15,
                  image: AssetImage('assets/logo.png'),
                ),
                Image(
                  width: size.width * 0.3,
                  image: AssetImage('assets/brand_name.png'),
                ),
              ],
            ),
            actions: [
              Container(
                child: IconButton(
                  icon: Icon(Icons.camera_alt_outlined),
                  color: theme.primaryColor,
                  onPressed: () {},
                ),
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
                            "CREATE NEW +",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
        Container(
          width: size.width * 0.2,
          height: size.height * 0.2,
          color: Colors.grey[200],
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<TabBloc>(context).add(
              TabUpdated(AppTab.reports),
            );
          },
          child: Container(
            color: Color(0xffFFBB33),
            height: size.height * 0.05,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Report list',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<TabBloc>(context).add(
              TabUpdated(AppTab.violations),
            );
          },
          child: Container(
            color: Color(0xffFFBB33),
            height: size.height * 0.05,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Violation list',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
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
