import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
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
          sort: 'desc id',
          limit: 2,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // print('snap: ' + snapshot.data.toString());
            if (snapshot.hasData && snapshot.data.length != 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ReportCard(report: snapshot.data[0]),
                    ReportCard(report: snapshot.data[1])
                  ],
                ),
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
