import 'package:capstone_mobile/generated/l10n.dart';
import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/constants/constant.dart';
import 'package:capstone_mobile/src/ui/screens/violation/excusion_screen.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_create_edit_screen.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ExtraAction { remove, edit, confirm, excuse }

class ActionPopupMenu extends StatelessWidget {
  const ActionPopupMenu({
    Key key,
    @required this.theme,
    @required this.violation,
    @required this.widget,
    @required this.successCallBack,
  }) : super(key: key);

  final ThemeData theme;
  final Violation violation;
  final Widget widget;
  final Function successCallBack;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_horiz,
        color: theme.primaryColor,
      ),
      onSelected: (action) {
        switch (action) {
          case ExtraAction.edit:
            Navigator.push(
                context,
                ViolationCreateEditScreen.route(
                  isEditing: true,
                  violation: violation.copyWith(),
                  successCallBack: successCallBack,
                ));
            break;
          case ExtraAction.remove:
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(S.of(context).POPUP_DELETE_VIOLATION),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        S.of(context).DELETE,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<ViolationBloc>(context)
                            .add(ViolationDelete(
                          token: BlocProvider.of<AuthenticationBloc>(context)
                              .state
                              .token,
                          id: violation.id,
                        ));
                        CoolAlert.show(
                          barrierDismissible: false,
                          context: context,
                          type: CoolAlertType.loading,
                          text: S.of(context).POPUP_CREATE_VIOLATION_SUBMITTING,
                        );
                      },
                    ),
                    TextButton(
                      child: Text(S.of(context).CANCEL),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
        PopupMenuItem<ExtraAction>(
          value: ExtraAction.edit,
          child: Text(S.of(context).EDIT),
        ),
        PopupMenuItem<ExtraAction>(
          value: ExtraAction.remove,
          child: Text(S.of(context).DELETE),
        ),
      ],
    );
  }
}

class ActionPopupMenuForBM extends StatelessWidget {
  const ActionPopupMenuForBM({
    Key key,
    @required this.theme,
    @required this.violation,
    @required this.widget,
    @required this.successCallBack,
  }) : super(key: key);

  final ThemeData theme;
  final Violation violation;
  final Widget widget;
  final Function successCallBack;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_horiz,
        color: theme.primaryColor,
      ),
      onSelected: (action) {
        switch (action) {
          case ExtraAction.excuse:
            Navigator.push(
                context,
                ExcuseScreen.route(
                  violation: violation,
                  successCallBack: successCallBack,
                ));
            break;
          case ExtraAction.confirm:
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(S.of(context).POPUP_DELETE_VIOLATION),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        S.of(context).CONFIRM,
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<ViolationBloc>(context)
                            .add(ViolationUpdate(
                          violation: violation.copyWith(
                            status: ViolationStatusConstant.CONFIRMED,
                          ),
                        ));
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text(
                        S.of(context).CANCEL,
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
        PopupMenuItem<ExtraAction>(
          value: ExtraAction.excuse,
          child: Text(S.of(context).EXCUSE),
        ),
        PopupMenuItem<ExtraAction>(
          value: ExtraAction.confirm,
          child: Text(S.of(context).CONFIRM),
        ),
      ],
    );
  }
}
