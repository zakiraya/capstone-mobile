import 'dart:async';

import 'package:http/http.dart' as http;

class ReportRepository {
  List<String> _report;

  ReportRepository();

  Future<List<String>> fetchReports(String token, {String status}) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    print('status: $status');

    if (status != null) {
      if (status == 'drafts') {
        return ["draft", "draft", "draft"];
      }
    }

    return ["1", "2", "3", "4", "4", "4", "4", "4", "4"];
  }
}
