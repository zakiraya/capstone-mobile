import 'package:capstone_mobile/Api/BaseApi.dart';
import 'package:capstone_mobile/src/data/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class UserApi {
  final http.Client httpClient;
  BaseApi baseApi = BaseApi();

  UserApi({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<String> signIn(String username, String password) async {
    final authenUrl = '/api/Auth/login';
    final body = <String, dynamic>{'username': username, 'password': password};

    final userJson =
        await baseApi.post(authenUrl, body) as Map<String, dynamic>;

    print(userJson['data']['accessToken']);
    return userJson['data']['accessToken'];
  }

  Future<User> getProfile(String id, {Map<String, String> opts}) async {
    final userUrl = '/api/employees/$id';

    final userJson =
        await baseApi.get(userUrl, opts: opts) as Map<String, dynamic>;
    return User.fromJson(userJson);
  }
}
