import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capstone_mobile/src/blocs/violation_list/violation_list_bloc.dart';
import 'package:capstone_mobile/src/ui/utils/modal_fit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
              Expanded(
                flex: 1,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/avt.jpg'),
                    ),
                  ),
                ),
              ),
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
                        "Branch: ${violation.branchId ?? ""}",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Violated date: ${"01 / 01 / 2021"}",
                            style: TextStyle(fontSize: 8),
                          ),
                          Text("Regulation: ${violation.regulationId ?? ""}",
                              style: TextStyle(fontSize: 8)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outlined,
                  size: 16.0,
                  color: Colors.red,
                ),
                onPressed: () {
                  context
                      .read<ViolationListBloc>()
                      .add(ViolationListRemove(position: position));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
