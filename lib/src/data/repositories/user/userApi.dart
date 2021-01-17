import 'package:capstone_mobile/src/data/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  static const baseUrl = 'https://d9aae2cd2a8b.ngrok.io';
  final http.Client httpClient;

  UserApi({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<User> signIn(String username, String password) async {
    final userUrl = '$baseUrl/auth/login-mobile';
    final userResponse = await this.httpClient.post(
          userUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{'username': username, 'password': password},
          ),
        );

    if (userResponse.statusCode != 200) {
      throw Exception(userResponse.statusCode);
    }

    final userJson = jsonDecode(userResponse.body);
    return User.fromJson(userJson);
  }
}
