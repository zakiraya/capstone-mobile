import 'package:capstone_mobile/src/ui/utils/modal_fit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ViolationCard extends StatelessWidget {
  const ViolationCard({
    Key key,
    this.errorCode,
    this.violationName,
    this.violator,
    this.violationDate,
    this.status,
  }) : super(key: key);

  final String errorCode;
  final String violationName;
  final String violator;
  final DateTime violationDate;
  final String status;

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
            builder: (context) => ModalFit(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
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
                      Text("#${errorCode ?? "error code"}"),
                      SizedBox(
                        height: 8,
                      ),
                      Text("${violationName ?? "Violation name"}"),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Violator: ${violator ?? "Hoang Gia Bao"}",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Violated date: ${violationDate.toString() ?? 01 / 01 / 2021}",
                            style: TextStyle(fontSize: 8),
                          ),
                          Text("Status: ${status ?? "Status"}",
                              style: TextStyle(fontSize: 8)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(
                Icons.edit_outlined,
                size: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
