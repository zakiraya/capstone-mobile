import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:cool_alert/cool_alert.dart';

import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_list/violation_list_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_card.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_create_modal.dart';

class ViolationListForm extends StatelessWidget {
  const ViolationListForm({
    Key key,
    @required this.theme,
    @required this.size,
  }) : super(key: key);

  final ThemeData theme;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViolationListBloc, ViolationListState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Transaction completed successfully!",
          );
        }
        if (state.status.isSubmissionFailure) {
          Navigator.pop(context);
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Oops...",
            text: "Sorry, something went wrong",
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            Container(
              child: Text(
                'New Violations',
                style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: theme.textTheme.headline4.fontSize),
              ),
            ),
            ViolationList(),
            Row(
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
                      showModalOne(
                        context,
                        isEditing: false,
                      );
                    },
                  ),
                ),
              ],
            ),
            _SubmitButton(size: size),
          ],
        ),
      ),
      // }
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViolationListBloc, ViolationListState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Container(
          width: size.width * 0.4,
          child: ElevatedButton(
            key: const Key('createForm_submit_raisedButton'),
            child: const Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            onPressed: state.status.isValidated
                ? () {
                    context.read<ViolationListBloc>().add(
                          ViolationListSubmitted(
                              token: context
                                  .read<AuthenticationBloc>()
                                  .state
                                  .token),
                        );
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: const Text('Submitting...'),
                            children: [
                              Center(
                                child: CircularProgressIndicator(),
                              )
                            ],
                          );
                        });
                  }
                : null,
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.red,
              primary: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ViolationList extends StatelessWidget {
  const ViolationList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViolationListBloc, ViolationListState>(
      // buildWhen: (previous, current) =>
      //     previous.violations.length != current.violations.length,
      builder: (context, state) {
        return Container(
          child: Column(
            children: [
              ...buildViolationList(state.violations ?? []),
            ],
          ),
        );
      },
    );
  }
}

List<Widget> buildViolationList(List<Violation> violations) {
  if (violations == null) return null;

  List<ViolationCard> violationCards = List<ViolationCard>();

  for (int i = 0; i < violations.length; i++) {
    ViolationCard card = ViolationCard(
      position: i,
      violation: violations[i],
    );
    violationCards.add(card);
  }
  return violationCards;
}

void showModalOne(
  BuildContext context, {
  Violation violation,
  int position,
  bool isEditing = false,
}) {
  final bloc = BlocProvider.of<ViolationListBloc>(context);
  var size = MediaQuery.of(context).size;
  showModalBottomSheet<List>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return ModalBody(
        bloc: bloc,
        size: size,
        isEditing: isEditing,
        violation: violation,
        position: position,
      );
    },
  ).then((value) {
    if (value != null && value[0] != null) {
      value[1] == null
          ? bloc.add(
              ViolationListChanged(
                violation: value[0],
              ),
            )
          : bloc.add(
              ViolationUpdate(
                position: value[1],
                violation: value[0],
              ),
            );
    }
  });
}
