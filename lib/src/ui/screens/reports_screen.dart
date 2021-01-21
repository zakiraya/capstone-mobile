import 'package:capstone_mobile/src/blocs/report/report_bloc.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_repository.dart';
import 'package:capstone_mobile/src/ui/screens/report_create_screen.dart';
import 'package:capstone_mobile/src/ui/screens/report_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ReportsScreen());
  }

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int groupValue = 0;

  final Map<int, Widget> segments = <int, Widget>{
    0: Container(child: Text('Reports')),
    1: Container(child: Text('Drafts'))
  };

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              tooltip: 'Notifications',
              onPressed: () {},
            ),
          ],
          // title: Text('Reports'),
          // centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => ReportBloc(reportRepository: ReportRepository())
            ..add(ReportRequested(token: "token")),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Report',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: theme.textTheme.headline1.fontSize),
                            ),
                          ),
                          Container(
                            child: Text(
                              'List',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: theme.textTheme.headline1.fontSize),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Center(
                            child: IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(context, CreateReportScreen.route());
                          },
                        )),
                        height: 50,
                        width: 75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0)),
                            color: Colors.orange),
                      ),
                    ]),
                SizedBox(
                  height: 15,
                ),
                Builder(
                  builder: (BuildContext context) {
                    return Center(
                      child: Container(
                        width: 400,
                        child: CupertinoSegmentedControl(
                          borderColor: Colors.orange,
                          selectedColor: Colors.orange,
                          groupValue: groupValue,
                          children: segments,
                          onValueChanged: (value) {
                            setState(() {
                              groupValue = value;
                            });

                            context.read<ReportBloc>().add(ReportRequested(
                                token: "token",
                                status: value == 0 ? null : "drafts"));
                          },
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                BlocBuilder<ReportBloc, ReportState>(
                  builder: (context, state) {
                    if (state is ReportLoadInProgress) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ReportLoadFailure) {
                      return Center(
                        child: Text('failed to fetch branch'),
                      );
                    } else if (state is ReportLoadSuccess) {
                      if (state.reports.isEmpty) {
                        return Center(
                          child: Text('There is no reports'),
                        );
                      }

                      return Expanded(
                        child: ListView.separated(
                          itemCount: state.reports.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(Icons.assignment_outlined),
                              title: Text("Branch ${state.reports[index]}"),
                              subtitle: Text("#$index"),
                              onTap: () {
                                Navigator.push(
                                    context, ReportDetailScreen.route());
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                            height: 0,
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Center(
                        child: Text("initial"),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          // )
        ));
  }
}
