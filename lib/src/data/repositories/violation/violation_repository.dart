import 'dart:async';

import 'package:capstone_mobile/Api/BaseApi.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ViolationRepository {
  ViolationApi _violationApi = ViolationApi(httpClient: http.Client());

  ViolationRepository();

  Future<List<Violation>> fetchViolations({
    @required String token,
    String sort,
    double page,
  }) async {
    return await _violationApi.getViolations(
      token: token,
      sort: sort,
      page: page,
    );
  }

  Future<String> createViolation({
    @required String token,
    @required List<Violation> violations,
  }) async {
    if (violations == null) {
      return 'fail';
    }

    if (violations.isEmpty) {
      return 'list violations are empty';
    }

    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InFjIiwicm9sZUlkIjoiMiIsInJvbGVOYW1lIjoiUUMgTWFuYWdlciIsImp0aSI6IjRlOTczM2Q1LTNjNGUtNDBhOC1hNDRlLTNlYjM0Y2M2NzVhZiIsIm5iZiI6MTYxMjQ5Nzc4MywiZXhwIjoxNjEyNDk4MDgzLCJpYXQiOjE2MTI0OTc3ODMsImF1ZCI6Ik1hdmNhIn0.q2VKRIrZHQLwjG3b9XWscGYW8GDmIN3kDwsRL87oiXg';

    // String imageUrl;
    // try {
    //   BaseApi baseApi = BaseApi();
    //   final uploadImage = await baseApi.uploadImage(
    //     'images/upload',
    //     violations[0].imagePath,
    //     token,
    //   );
    //   print('upload success: ');
    //   print(uploadImage['data'][0]['uri']);
    //   imageUrl = uploadImage['data'][0]['uri'];
    // } catch (e) {
    //   print(e);
    //   throw Exception('upload image fail');
    // }

    // violations[0].imagePath = imageUrl;

    List<String> imagePaths =
        violations.map((violation) => violation.imagePath).toList();

    var uploadedImages;
    try {
      BaseApi baseApi = BaseApi();
      uploadedImages = await baseApi.uploadImages(
        'images/upload',
        imagePaths,
        token,
      );
      print('upload success: ');
      print(uploadedImages['data']);
    } catch (e) {
      print(e);
      throw Exception('upload image fail');
    }

    for (int i = 0; i < violations.length; i++) {
      violations[i].imagePath = uploadedImages['data'][i]['uri'];
    }

    var result = await _violationApi.createViolations(
      token: token,
      violations: violations,
    );

    return result == 201 ? 'success' : 'fail';
  }
}
