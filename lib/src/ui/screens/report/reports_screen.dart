import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/ui/utils/image_picker.dart';
import 'package:capstone_mobile/src/ui/utils/skeleton_loading.dart';
import 'package:capstone_mobile/src/blocs/report/report_bloc.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_repository.dart';
import 'package:capstone_mobile/src/ui/screens/report/report_detail_screen.dart';

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
    0: Container(child: Text('Submitted Reports')),
    1: Container(child: Text('Drafts'))
  };

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        title: FlutterLogo(),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search_outlined,
              color: theme.primaryColor,
            ),
            tooltip: 'Search',
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: theme.primaryColor,
            ),
            tooltip: 'Notifications',
            onPressed: () {},
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => ReportBloc(reportRepository: ReportRepository())
          ..add(ReportRequested(
              token: BlocProvider.of<AuthenticationBloc>(context).state.token)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
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
                              color: theme.primaryColor,
                              fontSize: theme.textTheme.headline1.fontSize),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'List',
                              style: TextStyle(
                                  color: theme.primaryColor,
                                  fontSize: theme.textTheme.headline1.fontSize),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            children: [
                              Container(
                                height:
                                    (theme.textTheme.headline1.fontSize + 15) /
                                        2,
                                width: 46,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  ImagePickerButton(),
                ],
              ),
              // SizedBox(
              //   height: 15,
              // ),
              // Builder(
              //   builder: (BuildContext context) {
              //     return Center(
              //       child: Container(
              //         width: 400,
              //         child: CupertinoSegmentedControl(
              //           borderColor: Colors.orange[300],
              //           selectedColor: Colors.orange[300],
              //           groupValue: groupValue,
              //           children: segments,
              //           onValueChanged: (value) {
              //             setState(() {
              //               groupValue = value;
              //             });

              //             context.read<ReportBloc>().add(
              //                   ReportRequested(
              //                       token: "token",
              //                       status: value == 0 ? null : "Draft"),
              //                 );
              //           },
              //         ),
              //       ),
              //     );
              //   },
              // ),
              SizedBox(
                height: 16,
              ),
              BlocBuilder<ReportBloc, ReportState>(
                builder: (context, state) {
                  if (state is ReportLoadInProgress) {
                    return const Center(
                      child: SkeletonLoading(),
                    );
                  } else if (state is ReportLoadFailure) {
                    return Center(
                      child: Text('failed to fetch reports'),
                    );
                  } else if (state is ReportLoadSuccess) {
                    if (state.reports.isEmpty) {
                      return Center(
                        child: Text('There is no reports'),
                      );
                    }
                    List<Report> reports = state.reports;

                    return Expanded(
                      child: ListView.builder(
                        itemCount: reports.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 4,
                            shadowColor: Colors.purple[300],
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  ReportDetailScreen.route(
                                    report: reports[index],
                                    isEditable:
                                        reports[index].status.toLowerCase() ==
                                                'draft'
                                            ? true
                                            : false,
                                  ),
                                );
                              },
                              child: ClipPath(
                                clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          color: Colors.green, width: 5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "${'Branch: ' + reports[index].branchName ?? "branch name"}"),
                                            Text(
                                              "${reports[index].status ?? "Status"}",
                                              style: TextStyle(
                                                color: reports[index]
                                                            .status
                                                            .toLowerCase() ==
                                                        'draft'
                                                    ? Colors.grey
                                                    : (reports[index]
                                                                .status
                                                                .toLowerCase() ==
                                                            'pending'
                                                        ? Colors.blue
                                                        : Colors.green),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            "${'Report: ' + reports[index].name ?? "Report name"}"),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("5 mistakes"),
                                            Text(
                                                "${reports[index].createdAt ?? "date time"}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
        // )
      ),
    );
  }
}
