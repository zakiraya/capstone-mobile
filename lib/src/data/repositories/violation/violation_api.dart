import 'package:capstone_mobile/Api/BaseApi.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class ViolationApi {
  final http.Client httpClient;
  BaseApi baseApi = BaseApi();

  ViolationApi({@required this.httpClient});
}
