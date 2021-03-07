import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/ui/widgets/violation/dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:cool_alert/cool_alert.dart';

import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_list/violation_list_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_card.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_create_modal.dart';
import 'package:capstone_mobile/generated/l10n.dart';

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
            text: S.of(context).POPUP_CREATE_VIOLATION_SUCCESS,
          ).then((value) => {
                BlocProvider.of<ViolationBloc>(context).add(
                  ViolationRequested(
                    token: BlocProvider.of<AuthenticationBloc>(context)
                        .state
                        .token,
                    isRefresh: true,
                  ),
                )
              });
        }
        if (state.status.isSubmissionFailure) {
          Navigator.pop(context);
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Oops...",
            text: S.of(context).POPUP_CREATE_VIOLATION_FAIL,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            DropdownFieldBranch(),
            SizedBox(
              height: 16,
            ),
            ViolationList(),
            GestureDetector(
              onTap: () {
                showModalOne(
                  context,
                  isEditing: false,
                );
              },
              child: Card(
                elevation: 5,
                color: Color(0xffF2F2F2),
                child: Container(
                  height: size.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      Text(S.of(context).NEW_VIOLATION),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
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
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.27),
            child: ElevatedButton(
              key: const Key('createForm_submit_raisedButton'),
              child: Text(
                S.of(context).SUBMIT_BUTTON,
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
                                  .token,
                            ),
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
                                ),
                              ],
                            );
                          });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                elevation: 5,
                onPrimary: Colors.red,
                primary: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
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
              ViolationItemUpdate(
                position: value[1],
                violation: value[0],
              ),
            );
    }
  });
}
