import 'package:capstone_mobile/Api/BaseApi.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class ReportApi {
  final http.Client httpClient;
  BaseApi _baseApi = BaseApi();
  final reportUrl = 'reports';

  ReportApi({@required this.httpClient});

  Future<List<Report>> getReports({
    @required String token,
    @required String status,
    Map<String, String> opts,
  }) async {
    String url =
        reportUrl + '?Filter.IsDeleted=false' + '&Filter.Status=$status';
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InFjIiwicm9sZUlkIjoiMiIsInJvbGVOYW1lIjoiUUMgTWFuYWdlciIsImp0aSI6IjRlOTczM2Q1LTNjNGUtNDBhOC1hNDRlLTNlYjM0Y2M2NzVhZiIsIm5iZiI6MTYxMjQ5Nzc4MywiZXhwIjoxNjEyNDk4MDgzLCJpYXQiOjE2MTI0OTc3ODMsImF1ZCI6Ik1hdmNhIn0.q2VKRIrZHQLwjG3b9XWscGYW8GDmIN3kDwsRL87oiXg';
    final reportJson = await _baseApi.get(url, token, opts: opts);
    final reports = reportJson['data']['result'] as List;
    return reports.map((report) => Report.fromJson(report)).toList();
  }

  Future<int> createReport({
    @required String token,
    @required Map<String, String> opts,
    @required Report report,
  }) async {
    final url = reportUrl;
    final body = <String, dynamic>{
      ...report.toJson(),
    };

    final result = await _baseApi.post(
      url,
      body,
      token,
      opts: opts,
    );

    return result['code'];
  }
}
