import 'package:equatable/equatable.dart';

class ViolationFilter extends Equatable {
  final int branchId;
  final String status;
  final String name;

  ViolationFilter({this.branchId, this.status, this.name});

  @override
  List<Object> get props => [
        branchId,
        status,
        name,
      ];

  @override
  String toString() => '{ branchId: $branchId, status: $status, name: $name }';

  ViolationFilter copyWith({
    int branchId,
    String status,
    String name,
  }) {
    return ViolationFilter(
        branchId: branchId ?? this.branchId,
        status: status ?? this.status,
        name: name ?? this.name);
  }
}
