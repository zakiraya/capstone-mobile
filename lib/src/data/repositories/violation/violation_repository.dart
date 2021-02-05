import 'dart:async';

import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ViolationRepository {
  List<String> _violation;
  final ViolationApi violationApi;

  ViolationRepository({this.violationApi});

  Future<List<Violation>> fetchViolations({@required String token}) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    Violation vio1 = Violation(id: 1);
    Violation vio2 = Violation(id: 2);
    Violation vio3 = Violation(id: 3);
    return [vio1, vio2, vio3];
  }
}
