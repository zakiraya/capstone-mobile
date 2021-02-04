import 'package:capstone_mobile/Api/BaseApi.dart';
import 'package:capstone_mobile/src/data/models/branch/branch.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class BranchApi {
  final http.Client httpClient;
  BaseApi _baseApi = BaseApi();

  BranchApi({@required this.httpClient});

  Future<List<Branch>> getBranches({
    @required String token,
    Map<String, String> opts,
  }) async {
    final branchUrl = 'branches?Filter.IsDeleted=false';
    final userJson = await _baseApi.get(branchUrl, token, opts: opts);
    final branches = userJson['data']['result'] as List;
    return branches.map((branch) => Branch.fromJson(branch)).toList();
  }
}