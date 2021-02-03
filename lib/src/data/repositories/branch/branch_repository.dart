import 'dart:async';

import 'package:capstone_mobile/src/data/models/branch/branch.dart';
import 'package:capstone_mobile/src/data/repositories/branch/branch_api.dart';
import 'package:http/http.dart' as http;

class BranchRepository {
  List<Branch> _branches;
  BranchApi _branchApi = BranchApi(httpClient: http.Client());

  BranchRepository();

  Future<List<Branch>> fetchBranches(String token) async {
    String bearer = 'Bearer $token';
    return _branches = _branches != null
        ? _branches
        : await _branchApi
            .getBranches(opts: <String, String>{'Authorization': bearer});
  }
}
