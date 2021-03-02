import 'package:capstone_mobile/src/data/models/branch/branch.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ViolationFilter extends Equatable {
  final Branch branch;
  final String status;
  final String name;

  ViolationFilter({this.branch, this.status, this.name});

  @override
  List<Object> get props => [
        branch,
        status,
        name,
      ];
}
