import 'package:capstone_mobile/src/ui/constants/constant.dart';
import 'package:capstone_mobile/src/ui/widgets/violation/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capstone_mobile/src/blocs/blocs.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_create_screen.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_detail_screen.dart';
import 'package:capstone_mobile/src/ui/utils/image_picker.dart';
import 'package:capstone_mobile/src/ui/utils/skeleton_loading.dart';

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
                FilterButton(
                  visible: true,
                ),
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
                Expanded(
                    child: Container(
                  height: 24,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 8),
                      hintText: 'Search by regulation',
                      hintStyle: TextStyle(fontSize: 12),
                      suffixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (text) {
                      BlocProvider.of<ViolationBloc>(context).add(
                        ViolationFilterChanged(
                          token: BlocProvider.of<AuthenticationBloc>(context)
                              .state
                              .token,
                          filter: (BlocProvider.of<ViolationBloc>(context).state
                                  as ViolationLoadSuccess)
                              .activeFilter
                              .copyWith(name: text),
                        ),
                      );
                    },
                  ),
                )),
                FilterButton(
                  visible: true,
                ),
              ],
            ),
            _ViolationList(),
          ],
        ),
      ),
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
  final _scrollThreshold = 200.0;
  ViolationBloc _violationBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _violationBloc = BlocProvider.of<ViolationBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _violationBloc.add(
        ViolationRequested(
            token: BlocProvider.of<AuthenticationBloc>(context).state.token),
      );
    }
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
              Text('Fail to fetch violations'),
              ElevatedButton(
                onPressed: () {
                  _violationBloc.add(ViolationRequested(
                    token: BlocProvider.of<AuthenticationBloc>(context)
                        .state
                        .token,
                  ));
                },
                child: Text('Reload'),
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
            child: Text('There is no violations'),
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
              id: violation.id,
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
                    color: Constant.statusColors[violation.status], width: 5),
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
                        "${violation.branchName ?? "branch name"}",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${violation.status ?? "Status"}",
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
                        "submitted: " + "${violation.createdAt ?? "date time"}",
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

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
