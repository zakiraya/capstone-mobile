import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_repository.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_card.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_detail_screen.dart';
import 'package:capstone_mobile/src/ui/utils/skeleton_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class ReportDetailScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ReportDetailScreen());
  }

  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    String text = loremIpsum(words: 60);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        // title: Text('Report detail'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, top: 8, right: 16),
        child: ListView(
          children: [
            Container(
              child: Text(
                'Report of 01213231',
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: theme.textTheme.headline5.fontSize,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("Created by: Lai Van Some"),
                ),
                Container(
                  child: Text("Status: "),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("Branch: "),
                  ),
                  Text('Kichi Kichi - Branch 01'),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: Text("Created on: "),
                  ),
                  Text('28/12/1998'),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: Text("Submitted on: "),
                  ),
                  Text('30/12/1998'),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: Text("Description: "),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("$text"),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Text("Violation list: "),
            ),
            SizedBox(
              height: 16,
            ),
            BlocProvider(
              create: (context) =>
                  ViolationBloc(violationRepository: ViolationRepository())
                    ..add(ViolationRequested(token: "token")),
              child: BlocBuilder<ViolationBloc, ViolationState>(
                builder: (context, state) {
                  if (state is ViolationLoadInProgress) {
                    return Center(
                      child: SkeletonLoading(),
                    );
                  } else if (state is ViolationLoadFailure) {
                    return Center(
                      child: Text('Fail to fetch violations'),
                    );
                  } else if (state is ViolationLoadSuccess) {
                    if (state.violations.isEmpty) {
                      return Center(
                        child: Text('There is no violations'),
                      );
                    }
                    return buildViolationList(state.violations);
                  }
                  return Container();
                },
              ),
            ),
            SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildViolationList(List<Violation> violations) {
  List<ViolationCard> violationCards = List<ViolationCard>();
  for (var vio in violations) {
    ViolationCard card = ViolationCard();
    violationCards.add(card);
  }
  return Column(
    children: [...violationCards],
  );
}
