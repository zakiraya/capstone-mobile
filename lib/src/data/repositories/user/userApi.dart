import 'package:capstone_mobile/src/data/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  // static const baseUrl = 'https://d9aae2cd2a8b.ngrok.io';
  static const baseUrl = 'https://r-clothing-apis.herokuapp.com';
  static const authenPath = '/users/sign-in';
  // static const authenPath = '/auth/login-mobile';
  final http.Client httpClient;

  UserApi({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<String> signIn(String username, String password) async {
    final userUrl = 'https://r-clothing-apis.herokuapp.com/users/sign-in';
    final userResponse = await this.httpClient.post(
          userUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{'email': username, 'password': password},
          ),
        );

    if (userResponse.statusCode != 200) {
      throw Exception(userResponse.statusCode);
    }

    final userJson = jsonDecode(userResponse.body);
    return userJson['token'];
  }

  Future<User> getProfile(String username, String password,
      {dynamic opts}) async {
    final userUrl = '$baseUrl$authenPath';
    final userResponse = await this.httpClient.post(
          userUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{'email': username, 'password': password},
          ),
        );

    if (userResponse.statusCode != 200) {
      throw Exception(userResponse.statusCode);
    }

    final userJson = jsonDecode(userResponse.body);
    return User.fromJson(userJson);
  }
}
