import 'package:capstone_mobile/Api/BaseApi.dart';
import 'package:capstone_mobile/src/data/models/models.dart';
import '../../../../Api/Exceptions.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class AuthenticationException extends AppException {
  AuthenticationException([message]) : super(message, "Authentication error: ");
}

class UserApi {
  final http.Client httpClient;
  BaseApi baseApi = BaseApi();

  UserApi({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<String> signIn(String username, String password) async {
    final authenUrl = 'auth/login';
    final body = <String, dynamic>{'username': username, 'password': password};

    final userJson =
        await baseApi.post(authenUrl, body, null) as Map<String, dynamic>;

    if (userJson["code"] != 200) {
      throw Exception('Unauthenticated !');
    }

    return userJson['data']['accessToken'];
  }

  Future<User> getProfile(
    String token, {
    Map<String, String> opts,
  }) async {
    final url = 'employees/profile';

    final userJson =
        await baseApi.get(url, token, opts: opts) as Map<String, dynamic>;

    if (userJson['code'] != 200) {
      throw AuthenticationException('Error');
    }

    return User.fromJson(userJson);
  }
}
