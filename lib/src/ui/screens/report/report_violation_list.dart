import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_card.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_create_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportListViewViolation extends StatelessWidget {
  final bool isEditing;
  final List<Violation> violationCards = List<Violation>();

  ReportListViewViolation({Key key, this.isEditing = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCreateBloc, ReportCreateState>(
        buildWhen: (previous, current) =>
            previous.reportListViolation != current.reportListViolation,
        builder: (contex, state) {
          return Column(
            children: [
              ...buildViolationList(state.reportListViolation.value ?? []),
              isEditing == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.blue[900],
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              showModalOne(context);
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          );
        });
  }
}

List<Widget> buildViolationList(List<Violation> violations) {
  if (violations == null) return null;

  List<ViolationCard> violationCards = List<ViolationCard>();

  for (var vio in violations) {
    ViolationCard card = ViolationCard(
      errorCode: vio.violationCode,
      violationName: vio.regulationId.toString(),
    );
    violationCards.add(card);
  }
  return violationCards;
}

void showModalOne(BuildContext context) {
  final bloc = BlocProvider.of<ReportCreateBloc>(context);
  var size = MediaQuery.of(context).size;
  Future<Violation> future = showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return ModalBody(bloc: bloc, size: size);
    },
  );
  future.then((value) {
    bloc.add(
      ReportViolationsChanged(
        isEditing: true,
        reportViolation: Violation(
          violationName: value.violationName,
          description: value.description,
          regulationId: value.regulationId,
        ),
      ),
    );
  });
}
