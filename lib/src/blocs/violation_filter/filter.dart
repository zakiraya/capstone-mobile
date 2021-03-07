import 'package:equatable/equatable.dart';

class Filter extends Equatable {
  final int branchId;
  final String status;
  final String name;

  Filter({this.branchId, this.status, this.name});

  @override
  List<Object> get props => [
        branchId,
        status,
        name,
      ];

  @override
  String toString() => '{ branchId: $branchId, status: $status, name: $name }';

  Filter copyWith({
    int branchId,
    String status,
    String name,
  }) {
    return Filter(
        branchId: branchId ?? this.branchId,
        status: status ?? this.status,
        name: name ?? this.name);
  }
}
