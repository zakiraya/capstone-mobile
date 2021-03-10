import 'package:capstone_mobile/src/blocs/localization/localization_bloc.dart';
import 'package:capstone_mobile/src/ui/constants/constant.dart';
import 'package:capstone_mobile/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capstone_mobile/src/blocs/blocs.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/blocs/branch/branch_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_create_screen.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_detail_screen.dart';
import 'package:capstone_mobile/src/ui/utils/image_picker.dart';
import 'package:capstone_mobile/src/ui/utils/dropdown.dart';
import 'package:capstone_mobile/src/ui/utils/skeleton_loading.dart';
import 'package:capstone_mobile/generated/l10n.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:capstone_mobile/src/ui/utils/modal_fit.dart';
import 'package:capstone_mobile/src/ui/utils/bottom_loader.dart';
import 'package:capstone_mobile/src/blocs/violation_filter/violation_filter_bloc.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class ViolationScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        settings: RouteSettings(name: "/ViolationScreen"),
        builder: (_) => ViolationScreen());
  }

  @override
  _ViolationScreenState createState() => _ViolationScreenState();
}

class _ViolationScreenState extends State<ViolationScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        title: FlutterLogo(),
      ),
      floatingActionButton: Column(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
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
                        'Violation',
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: theme.textTheme.headline1.fontSize,
                        ),
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
                              fontSize: theme.textTheme.headline1.fontSize,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          children: [
                            Container(
                              height:
                                  (theme.textTheme.headline1.fontSize + 15) / 2,
                              width: 46,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.black, width: 2),
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
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                // FilterButton(
                //   visible: true,
                // ),
              ],
            ),
            _ViolationList(),
          ],
        ),
      ),
    );
  }
}

class ViolationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
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
                // Expanded(
                //     child: Container(
                //   height: 24,
                //   child: TextField(
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(24),
                //       ),
                //       contentPadding: const EdgeInsets.symmetric(
                //           vertical: 2.0, horizontal: 8),
                //       hintText: 'Search by regulation',
                //       hintStyle: TextStyle(fontSize: 12),
                //       suffixIcon: Icon(Icons.search),
                //     ),
                //     onSubmitted: (text) {
                //       BlocProvider.of<ViolationBloc>(context).add(
                //         FilterChanged(
                //           token: BlocProvider.of<AuthenticationBloc>(context)
                //               .state
                //               .token,
                //           filter: (BlocProvider.of<ViolationBloc>(context).state
                //                   as ViolationLoadSuccess)
                //               .activeFilter
                //               .copyWith(regulationId: 1),
                //         ),
                //       );
                //     },
                //   ),
                // )),
                // FilterButton(
                //   visible: true,
                // ),
              ],
            ),
            ViolationListFilter(),
            _ViolationList(),
          ],
        ),
      ),
    );
  }
}

class ViolationListFilter extends StatelessWidget {
  const ViolationListFilter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Container(
              width: 64,
              child: Text('Branch: '),
            ),
            BlocBuilder<ViolationFilterBloc, ViolationFilterState>(
                builder: (context, state) {
              return GestureDetector(
                onTap: () => showMaterialModalBottomSheet(
                  expand: false,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ModalFit(
                    title: 'Branches',
                    list: (BlocProvider.of<BranchBloc>(context).state
                            as BranchLoadSuccess)
                        .branches,
                    value: state.filter.branchId,
                  ),
                ).then((value) {
                  if (value != null) {
                    BlocProvider.of<ViolationFilterBloc>(context)
                        .add(ViolationFilterBranchIdUpdated(
                      token: BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .token,
                      branchId: state.filter.branchId == value ? null : value,
                    ));
                  }
                }),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 112),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                      border: Border.all(),
                    ),
                    // color: Colors.grey[200],
                    height: 32,
                    child: Center(
                      child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(Utils.findBranchName(
                                        state.filter.branchId, context) ??
                                    'All branches'),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ]),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        // Row(
        //   children: [
        //     Text('Regulation: '),
        //     BlocBuilder<ViolationFilterBloc, ViolationFilterState>(
        //         builder: (context, state) {
        //       return GestureDetector(
        //         onTap: () => showMaterialModalBottomSheet(
        //           expand: false,
        //           context: context,
        //           backgroundColor: Colors.transparent,
        //           builder: (context) => ModalFit(
        //               title: 'Regulations',
        //               list: (BlocProvider.of<RegulationBloc>(context).state
        //                       as RegulationLoadSuccess)
        //                   .regulations),
        //         ).then((value) {
        //           BlocProvider.of<ViolationBloc>(context).add(
        //             FilterChanged(
        //               token: BlocProvider.of<AuthenticationBloc>(context)
        //                   .state
        //                   .token,
        //               filter: Filter(regulationId: value),
        //             ),
        //           );
        //           BlocProvider.of<ViolationFilterBloc>(context)
        //               .add(ViolationFilterRegulationUpdated(
        //             regulationId: value,
        //           ));
        //         }),
        //         child: Container(
        //           color: Colors.grey[200],
        //           height: 32,
        //           child: Row(children: [
        //             Text(findRegulationName(
        //                     state.filter.regulationId, context) ??
        //                 ''),
        //             Icon(Icons.arrow_drop_down),
        //           ]),
        //         ),
        //       );
        //     }),
        //   ],
        // ),
        Row(
          children: [
            Container(
              width: 64,
              child: Text('Status: '),
            ),
            StatusDropdown(
                onChanged: (value) {
                  BlocProvider.of<ViolationFilterBloc>(context)
                      .add(ViolationFilterStatusUpdated(
                    token: BlocProvider.of<AuthenticationBloc>(context)
                        .state
                        .token,
                    status: value,
                  ));
                },
                list: ['Opening', 'Rejected', 'Confirmed', 'Excused']),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: [
            Container(
              width: 64,
              child: Text('Month: '),
            ),
            BlocBuilder<ViolationFilterBloc, ViolationFilterState>(
                builder: (context, state) {
              return GestureDetector(
                onTap: () => showMonthPicker(
                  context: context,
                  firstDate: DateTime(DateTime.now().year - 1, 5),
                  lastDate: DateTime(DateTime.now().year + 1, 9),
                  initialDate: DateTime.now(),
                  locale:
                      Locale(BlocProvider.of<LocalizationBloc>(context).state),
                ).then((value) {
                  if (value != null) {
                    print(value);
                    BlocProvider.of<ViolationFilterBloc>(context)
                        .add(ViolationFilterMonthUpdated(
                      token: BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .token,
                      month: value,
                    ));
                  }
                }),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 80),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                      border: Border.all(),
                    ),
                    // color: Colors.grey[200],
                    height: 32,
                    child: Center(
                      child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  state.filter.month != null
                                      ? state.filter.month.month.toString()
                                      : DateTime.now().month.toString(),
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ]),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ]),
    );
  }
}

class _ViolationList extends StatefulWidget {
  const _ViolationList({
    Key key,
  }) : super(key: key);

  @override
  __ViolationListState createState() => __ViolationListState();
}

class __ViolationListState extends State<_ViolationList> {
  final _scrollController = ScrollController();
  ViolationBloc _violationBloc;

  @override
  void initState() {
    super.initState();
    _violationBloc = BlocProvider.of<ViolationBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViolationBloc, ViolationState>(
        builder: (context, state) {
      if (state is ViolationLoadInProgress) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ViolationLoadFailure) {
        return Center(
          child: Column(
            children: [
              Text(S.of(context).VIOLATION_SCREEN_FETCH_FAIL),
              ElevatedButton(
                onPressed: () {
                  _violationBloc.add(ViolationRequested(
                    token: BlocProvider.of<AuthenticationBloc>(context)
                        .state
                        .token,
                  ));
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

      if (state is ViolationLoadSuccess) {
        if (state.violations.isEmpty) {
          return Center(
            child: Text(S.of(context).VIOLATION_SCREEN_NO_VIOLATIONS),
          );
        }

        List<Violation> violations = state.violations;

        return Expanded(
            child: NotificationListener<ScrollEndNotification>(
          onNotification: (scrollEnd) {
            var metrics = scrollEnd.metrics;
            if (metrics.atEdge) {
              if (metrics.pixels == 0) {
                _violationBloc.add(ViolationRequested(
                  token:
                      BlocProvider.of<AuthenticationBloc>(context).state.token,
                  isRefresh: true,
                  filter: state.activeFilter,
                ));
              } else {
                _violationBloc.add(
                  ViolationRequested(
                    token: BlocProvider.of<AuthenticationBloc>(context)
                        .state
                        .token,
                    filter: state.activeFilter,
                  ),
                );
              }
            }
            return true;
          },
          child: ListView.builder(
              itemCount:
                  (_violationBloc.state as ViolationLoadSuccess).hasReachedMax
                      ? state.violations.length
                      : state.violations.length + 1,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return index >= state.violations.length
                    ? BottomLoader()
                    : ViolationCard(violation: violations[index]);
              }),
        ));
      }
      return Container(
        child: Center(
          child: SkeletonLoading(
            item: 4,
          ),
        ),
      );
    });
  }
}

class ViolationCard extends StatelessWidget {
  ViolationCard({
    Key key,
    @required this.violation,
  }) : super(key: key);

  final Violation violation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            ViolationDetailScreen.route(
              violation: violation,
              id: violation?.id,
            ),
          );
        },
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    color:
                        Constant.statusColors[violation.status] ?? Colors.green,
                    width: 5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${violation?.branchName ?? "branch name"}",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${violation?.status ?? "Status"}",
                        style: TextStyle(
                          color: Constant.statusColors[violation.status],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${violation.regulationName ?? 'Regulation name'}",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
                      Text(
                        S.of(context).CREATED_ON +
                            ": ${violation.createdAt ?? "date time"}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
