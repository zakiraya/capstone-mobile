import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_create_modal.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_create_list_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capstone_mobile/src/blocs/violation_list/violation_list_bloc.dart';
import 'package:capstone_mobile/src/ui/utils/modal_fit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

enum ExtraAction { remove, edit }

class ViolationCard extends StatelessWidget {
  const ViolationCard({
    Key key,
    this.position,
    this.violation,
  }) : super(key: key);

  final int position;
  final Violation violation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.purple[300],
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          showMaterialModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => ModalFit(
              violation: violation,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     width: 80,
              //     height: 80,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(2),
              //       image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: AssetImage('assets/avt.jpg'),
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("#${violation.violationCode ?? "error code"}"),
                      SizedBox(
                        height: 8,
                      ),
                      Text("${violation.name ?? "Violation name"}"),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Branch: ${violation.branchName ?? ""}",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(
                          //   "Violated date: ${"01 / 01 / 2021"}",
                          //   style: TextStyle(fontSize: 8),
                          // ),
                          Text("Regulation: ${violation.regulationName ?? ""}",
                              style: TextStyle(fontSize: 8)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuButton(
                onSelected: (action) {
                  switch (action) {
                    case ExtraAction.edit:
                      // BlocProvider.of<ViolationListBloc>(context)
                      //     .add(ViolationUpdate(
                      //   position: position,
                      //   violation: violation,
                      // ));
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
                    child: Text('Edit'),
                  ),
                  PopupMenuItem<ExtraAction>(
                    value: ExtraAction.remove,
                    child: Text('Remove'),
                  ),
                ],
              )
              // IconButton(
              //   icon: const Icon(
              //     Icons.delete_outlined,
              //     size: 16.0,
              //     color: Colors.red,
              //   ),
              //   onPressed: () {
              //     context
              //         .read<ViolationListBloc>()
              //         .add(ViolationListRemove(position: position));
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

void showEditViolationModal(
  BuildContext context,
  Violation violation,
  int position,
  bool isEditing,
) {
  final bloc = BlocProvider.of<ViolationListBloc>(context);
  var size = MediaQuery.of(context).size;
  Future<Violation> future = showModalBottomSheet(
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
  );
}
