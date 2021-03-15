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
    int limit,
    String status,
    int branchId,
    int regulationId,
    DateTime date,
  }) async {
    return await _violationApi.getViolations(
      token: token,
      sort: sort,
      page: page,
      limit: limit,
      branchId: branchId,
      regulationId: regulationId,
      status: status,
      date: date,
    );
  }

  Future<String> createViolations({
    @required String token,
    @required List<Violation> violations,
  }) async {
    if (violations == null) {
      return 'fail';
    }

    if (violations.isEmpty) {
      return 'list violations are empty';
    }

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

  Future<String> editViolation({
    @required String token,
    @required Violation violation,
  }) async {
    var uploadedImage;

    if (!violation.imagePath.contains('http')) {
      BaseApi baseApi = BaseApi();
      uploadedImage = await baseApi.uploadImage(
        'images/upload',
        violation.imagePath,
        token,
      );
      violation.imagePath = uploadedImage['data'][0]['uri'];
    }

    var result = await _violationApi.editViolation(
      token: token,
      violation: violation,
    );

    return result == 200 ? 'success' : 'fail';
  }

  Future<String> deleteViolation({
    @required String token,
    @required int id,
  }) async {
    var result = await _violationApi.deleteViolation(token: token, id: id);

    return result == 200 ? 'success' : 'fail';
  }
}
