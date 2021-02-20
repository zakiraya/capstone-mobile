import 'dart:async';

import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_api.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ReportRepository {
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

    // var reportCode = await _reportApi.createReport(
    //   token: token,
    //   opts: <String, String>{
    //     'Authorization': bearer,
    //   },
    //   report: report,
    // );

    // if (reportCode != 201) return 'fail';

    ViolationRepository violationRepository = ViolationRepository();

    report.violations.forEach((violation) {
      violation.branchId = report.branchId;
    });

    var violation = await violationRepository.createViolation(
      token: token,
      violations: report.violations,
    );

    return violation;
  }

  Future<String> editReport({
    @required String token,
    @required Report report,
    bool isDraft = true,
  }) async {
    isDraft
        ? report = report.copyWith(status: 'Draft')
        : report = report.copyWith(status: 'Pending');

    var result = await _reportApi.editReport(
      token: token,
      report: report,
    );

    return result == 200 ? 'success' : 'fail';
  }

  Future<String> deleteReport({
    @required String token,
    @required int id,
  }) async {
    var result = await _reportApi.deleteReport(token: token, id: id);

    return result == 200 ? 'success' : 'fail';
  }
}
