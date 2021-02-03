import 'dart:async';

import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ReportRepository {
  List<Report> _report = [
    Report(name: "report 1", status: "done"),
    Report(name: "report 2", status: "rejected"),
    Report(name: "report 3", status: "draft"),
  ];

  ReportRepository();

  Future<List<Report>> fetchReports(String token, {String status}) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    if (status != null) {
      if (status == 'drafts') {
        return _report.where((element) => element.status == "draft").toList();
      }
    }
    print("length: ${_report.length}");

    return _report
        .where((element) =>
            element.status == "done" || element.status == "rejected")
        .toList();
  }

  Future<String> createReport({
    @required String token,
    @required Report report,
    @required bool isDraft,
  }) async {
    if (report == null) {
      return 'fail';
    }

    report.props.forEach((element) {
      print(element);
    });

    isDraft == true
        ? _report.add(Report(
            name: report.name,
            description: report.description,
            status: 'draft'))
        : _report.add(Report(
            name: report.name,
            description: report.description,
            status: 'done'));

    await Future<void>.delayed(const Duration(seconds: 2));
    return 'success';
  }
}
