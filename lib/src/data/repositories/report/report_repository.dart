import 'dart:async';

import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ReportRepository {
  List<Report> _report = [
    Report(name: "report 1", status: "done"),
    Report(name: "report 2", status: "rejected"),
    Report(name: "report 3", status: "draft"),
  ];

  ReportRepository();
  ReportApi _reportApi = ReportApi(httpClient: http.Client());

  Future<List<Report>> fetchReports(String token, {String status}) async {
    return _report
        .where((element) =>
            element.status == "done" || element.status == "rejected")
        .toList();
  }

  Future<String> createReportFake({
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

  Future<String> createReport({
    @required String token,
    @required Report report,
    bool isDraft = true,
  }) async {
    if (report == null) {
      return 'fail';
    }

    String bearer = 'Bearer $token';

    isDraft
        ? report = report.copyWith(status: 'Draft')
        : report = report.copyWith(status: 'Pending');

    // report.props.forEach((element) {
    //   print(element);
    // });

    var result = await _reportApi.createReport(
      token: token,
      opts: <String, String>{
        'Authorization': bearer,
      },
      report: report,
    );

    return result == 201 ? 'success' : 'fail';
  }
}
