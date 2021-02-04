import 'package:capstone_mobile/Api/BaseApi.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class ReportApi {
  final http.Client httpClient;
  BaseApi _baseApi = BaseApi();
  final reportUrl = 'reports';

  ReportApi({@required this.httpClient});

  Future<List<Report>> getReports(
      {@required String token, @required Map<String, String> opts}) async {
    String url = reportUrl;
    final reportJson = await _baseApi.get(url, token, opts: opts);
    final reports = reportJson['data']['result'] as List;
    return reports.map((report) => Report.fromJson(report));
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
