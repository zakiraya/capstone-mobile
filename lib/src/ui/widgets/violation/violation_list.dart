import 'package:capstone_mobile/generated/l10n.dart';
import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_by_demand/violation_by_demand_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_repository.dart';
import 'package:capstone_mobile/src/ui/utils/skeleton_loading.dart';
import 'package:capstone_mobile/src/ui/widgets/violation/violation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class LatesViolationList extends StatelessWidget {
//   final ViolationRepository _violationRepository = ViolationRepository();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: _violationRepository.fetchViolations(
//           token: BlocProvider.of<AuthenticationBloc>(context).state.token,
//           sort: 'desc createdAt',
//           // status: 'Opening',
//           id: 92,
//           // limit: 2,
//           // onDate: DateTime.now(),
//         ),
//         builder: (context, snapshot) {
//           if (snapshot.hasData &&
//               snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.data.length != 0) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: buildViolationList([
//                   ...snapshot.data,
//                 ]),
//               );
//             }
//             return Container();
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//                 child: SkeletonLoading(
//               item: 2,
//             ));
//           }
//           return Center(
//             child: Text(snapshot.connectionState.toString()),
//           );
//         });
//   }
// }

class LatestViolationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViolationByDemandBloc, ViolationByDemandState>(
        builder: (context, state) {
      if (state is ViolationByDemandLoadInProgress) {
        return Center(
          child: SkeletonLoading(
            item: 2,
          ),
        );
      }
      if (state is ViolationByDemandLoadFailure) {
        return Center(
            child: Column(
          children: [
            Container(
              child: Text(
                  S.of(context).THERE_IS_NO + ' ' + S.of(context).VIOLATION),
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<ViolationByDemandBloc>(context)
                    .add(ViolationRequestedByDate(date: DateTime.now()));
              },
              child: Text(S.of(context).VIOLATION_SCREEN_RELOAD),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[200],
                onPrimary: Colors.black,
              ),
            ),
          ],
        ));
      }
      if (state is ViolationByDemandLoadSuccess) {
        var violations = state.violations;

        if (violations.isEmpty) {
          return Center(
            child:
                Text(S.of(context).THERE_IS_NO + ' ' + S.of(context).VIOLATION),
          );
        }

        return buildViolationList(
          violations,
          bloc: BlocProvider.of<ViolationByDemandBloc>(context),
          screen: 'Home',
        );
      }
      return Container();
    });
  }
}

class ViolationByReportList extends StatelessWidget {
  final int reportId;

  const ViolationByReportList({Key key, this.reportId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViolationByDemandBloc, ViolationByDemandState>(
        builder: (context, state) {
      if (state is ViolationByDemandLoadInProgress) {
        return Center(
          child: SkeletonLoading(
            item: 2,
          ),
        );
      }
      if (state is ViolationByDemandLoadFailure) {
        return Center(
            child: Column(
          children: [
            Container(
              child: Text(
                  S.of(context).THERE_IS_NO + ' ' + S.of(context).VIOLATION),
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<ViolationByDemandBloc>(context)
                    .add(ViolationRequestedByReportId(reportId: reportId));
              },
              child: Text(S.of(context).VIOLATION_SCREEN_RELOAD),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[200],
                onPrimary: Colors.black,
              ),
            ),
          ],
        ));
      }
      if (state is ViolationByDemandLoadSuccess) {
        var violations = state.violations;

        if (violations.isEmpty) {
          return Center(
            child:
                Text(S.of(context).THERE_IS_NO + ' ' + S.of(context).VIOLATION),
          );
        }

        return buildViolationList(
          violations,
          bloc: BlocProvider.of<ViolationByDemandBloc>(context),
          screen: 'ReportDetailScreen',
        );
      }
      return Container();
    });
  }
}

Widget buildViolationList(
  List<Violation> violations, {
  bloc,
  screen,
}) {
  List<ViolationCard> violationCards = List<ViolationCard>();
  for (var vio in violations) {
    ViolationCard card = ViolationCard(
      violation: vio,
      isFetchedById: true,
      bloc: bloc,
      fromScreen: screen,
    );
    violationCards.add(card);
  }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      children: [...violationCards],
    ),
  );
}

// class ViolationByReportList extends StatelessWidget {
//   final ViolationRepository _violationRepository = ViolationRepository();
//   final int reportId;

//   ViolationByReportList({Key key, this.reportId}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: _violationRepository.fetchViolations(
//           token: BlocProvider.of<AuthenticationBloc>(context).state.token,
//           sort: 'desc createdAt',
//           reportId: reportId,
//         ),
//         builder: (context, snapshot) {
//           if (snapshot.hasData &&
//               snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.data.length != 0) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: buildViolationList([
//                   ...snapshot.data,
//                 ]),
//               );
//             }
//             return Container();
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//                 child: SkeletonLoading(
//               item: 2,
//             ));
//           }
//           return Center(
//             child: Text(snapshot.connectionState.toString()),
//           );
//         });
//   }
// }
