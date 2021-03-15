import 'package:capstone_mobile/generated/l10n.dart';
import 'package:capstone_mobile/src/blocs/localization/localization_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_list/violation_list_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/constants/constant.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_create_list_form.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_detail_screen.dart';
import 'package:capstone_mobile/src/ui/utils/modal_fit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
              id: violation?.id,
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
                    color: Constant.violationStatusColors[violation.status] ??
                        Colors.green,
                    width: 5),
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
                        "${violation?.branchName ?? "branch name"}",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${violation?.status ?? "Status"}",
                        style: TextStyle(
                          color:
                              Constant.violationStatusColors[violation.status],
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
                        S.of(context).CREATED_ON +
                            ": ${DateFormat.yMMMd(BlocProvider.of<LocalizationBloc>(context).state).format(violation.createdAt) ?? "date time"}",
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

enum ExtraAction { remove, edit }

class ViolationCreateCard extends StatelessWidget {
  const ViolationCreateCard({
    Key key,
    this.position,
    this.violation,
  }) : super(key: key);

  final int position;
  final Violation violation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          showMaterialModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => ViolationModalFit(
              violation: violation,
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
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey[200], width: 5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(S.of(context).VIOLATION +
                                  ' ' +
                                  S.of(context).BELONGS_TO +
                                  ' ' +
                                  "${violation.regulationName ?? "Violation name"}"),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuButton(
                        onSelected: (action) {
                          switch (action) {
                            case ExtraAction.edit:
                              showModalOne(
                                context,
                                violation: violation,
                                position: position,
                                isEditing: true,
                              );
                              break;
                            case ExtraAction.remove:
                              BlocProvider.of<ViolationListBloc>(context)
                                  .add(ViolationListRemove(
                                position: position,
                              ));
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuItem<ExtraAction>>[
                          PopupMenuItem<ExtraAction>(
                            value: ExtraAction.edit,
                            child: Text(S.of(context).EDIT),
                          ),
                          PopupMenuItem<ExtraAction>(
                            value: ExtraAction.remove,
                            child: Text(S.of(context).DELETE),
                          ),
                        ],
                      )
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
