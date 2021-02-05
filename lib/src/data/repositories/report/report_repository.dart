import 'dart:async';

import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ReportRepository {
  List<Report> _reportFake = [
    Report(name: "report 1", status: "done"),
    Report(name: "report 2", status: "rejected"),
    Report(name: "report 3", status: "draft"),
  ];

  ReportRepository();
  ReportApi _reportApi = ReportApi(httpClient: http.Client());

  Future<List<Report>> fetchReports({
    @required String token,
    @required String status,
  }) async {
    if (status == 'Draft') {
      return await _reportApi.getReports(
        token: token,
        status: status,
      );
    }

    List<Report> pendingReports = List();

    pendingReports = await _reportApi.getReports(
      token: token,
      status: 'Pending',
    );

    List<Report> doneReports = List();
    doneReports = await _reportApi.getReports(
      token: token,
      status: 'Done',
    );

    return <Report>[
      ...pendingReports,
      ...doneReports,
    ];
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
