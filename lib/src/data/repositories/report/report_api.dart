import 'package:capstone_mobile/Api/BaseApi.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class ReportApi {
  final http.Client httpClient;
  BaseApi baseApi = BaseApi();

  ReportApi({@required this.httpClient});
}
