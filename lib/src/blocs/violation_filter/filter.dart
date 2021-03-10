import 'package:equatable/equatable.dart';

class Filter extends Equatable {
  final int branchId;
  final String status;
  final int regulationId;
  final DateTime month;

  Filter({
    this.branchId,
    this.status,
    this.regulationId,
    this.month,
  });

  @override
  List<Object> get props => [
        branchId,
        status,
        regulationId,
        month,
      ];

  @override
  String toString() =>
      '{ branchId: $branchId, status: $status, regulationId: $regulationId , month: $month }';

  Filter copyWith({
    int branchId,
    String status,
    int regulationId,
    DateTime month,
  }) {
    return Filter(
      branchId: branchId ?? this.branchId,
      status: status ?? this.status,
      regulationId: regulationId ?? this.regulationId,
      month: month ?? this.month,
    );
  }
}
