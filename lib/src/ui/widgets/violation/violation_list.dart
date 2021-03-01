import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_repository.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_screen.dart';
import 'package:capstone_mobile/src/ui/utils/skeleton_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatesViolationList extends StatelessWidget {
  final ViolationRepository _violationRepository = ViolationRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _violationRepository.fetchViolations(
          token: BlocProvider.of<AuthenticationBloc>(context).state.token,
          sort: 'desc id',
          limit: 2,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.length != 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildViolationList([
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

Widget buildViolationList(List<Violation> violations) {
  List<ViolationCard> violationCards = List<ViolationCard>();
  for (var vio in violations) {
    ViolationCard card = ViolationCard(
      violation: vio,
    );
    violationCards.add(card);
  }
  return Column(
    children: [...violationCards],
  );
}