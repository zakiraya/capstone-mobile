import 'package:flutter/material.dart';

import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/ui/screens/report/report_detail_screen.dart';
import 'package:capstone_mobile/src/ui/constants/constant.dart';
import 'package:capstone_mobile/generated/l10n.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    Key key,
    @required this.report,
  }) : super(key: key);

  final Report report;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            ReportDetailScreen.route(
              report: report,
              // isEditable: report.status.toLowerCase() == 'draft' ? true : false,
            ),
          );
        },
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Constant.reportStatusColors[report.status] ??
                      Colors.black,
                  width: 5,
                ),
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
                        // "${report.branchName ?? "branch name"}",
                        '',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${report.status ?? "Status"}",
                        style: TextStyle(
                          color: Constant.reportStatusColors[report.status],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${report?.name ?? "Report name"}",
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
                            ': '
                                "${report?.createdAt ?? "date time"}",
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
