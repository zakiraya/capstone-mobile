import 'package:equatable/equatable.dart';

class Filter extends Equatable {
  final int branchId;
  final String status;
  final int regulationId;

  Filter({this.branchId, this.status, this.regulationId});

  @override
  List<Object> get props => [
        branchId,
        status,
        regulationId,
      ];

  @override
  String toString() =>
      '{ branchId: $branchId, status: $status, regulationId: $regulationId }';

  Filter copyWith({
    int branchId,
    String status,
    int regulationId,
  }) {
    return Filter(
      branchId: branchId ?? this.branchId,
      status: status ?? this.status,
      regulationId: regulationId ?? this.regulationId,
    );
  }
}
