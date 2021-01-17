import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'Exceptions.dart';

class ApiBase {
  final String _baseUrl = "";

  Map<String, String> generateHeader([Map<String, String> opts]) {
    return {'Content-Type': 'application/json; charset=UTF-8', ...opts};
  }

  Future<dynamic> get(String url, {Map<String, String> opts}) async {
    var responseJson;
    try {
      final response =
          await http.get(_baseUrl + url, headers: generateHeader(opts));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body,
      {Map<String, String> opts}) async {
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url,
          headers: generateHeader(opts),
          body: jsonEncode(<String, String>{...body}));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body,
      {Map<String, String> opts}) async {
    var responseJson;
    try {
      final response = await http.put(_baseUrl + url,
          headers: generateHeader(opts),
          body: jsonEncode(<String, String>{...body}));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> delete(String url, {Map<String, String> opts}) async {
    var responseJson;
    try {
      final response = await http.delete(
        _baseUrl + url,
        headers: generateHeader(opts),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    String body = response.body.toString();
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(body);
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(body);
      case 401:
      case 403:
        throw UnauthorisedException(body);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
