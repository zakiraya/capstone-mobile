import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_repository.dart';
import 'package:capstone_mobile/src/ui/utils/skeleton_loading.dart';
import 'package:capstone_mobile/src/ui/widgets/report/report_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatestReportList extends StatelessWidget {
  final ReportRepository _reportRepository = ReportRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _reportRepository.fetchReports(
          token: BlocProvider.of<AuthenticationBloc>(context).state.token,
          sort: 'desc createdAt',
          limit: 2,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data.length != 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildReportList([
                  ...snapshot.data,
                ]),
              );
            }
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: SkeletonLoading(
              item: 2,
            ));
          }
          return Center(
            child: Text(snapshot.connectionState.toString()),
          );
        });
  }
}

Widget buildReportList(List<Report> reports) {
  List<ReportCard> reportCards = List<ReportCard>();
  for (var report in reports) {
    ReportCard card = ReportCard(
      report: report,
    );
    reportCards.add(card);
  }
  return Column(
    children: [...reportCards.reversed],
  );
}
