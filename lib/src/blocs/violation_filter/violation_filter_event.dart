part of 'violation_filter_bloc.dart';

abstract class ViolationFilterEvent extends Equatable {
  const ViolationFilterEvent();

  @override
  List<Object> get props => [];
}

// class FilterUpdated extends ViolationFilterEvent {
//   final String filter;

//   FilterUpdated(this.filter);

//   @override
//   List<Object> get props => [filter];

//   @override
//   String toString() => 'FilterUpdated { filter: $filter }';
// }
class FilterUpdated extends ViolationFilterEvent {
  final Filter filter;

  FilterUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdated { filter: $filter }';
}

class ViolationFilterBranchIdUpdated extends ViolationFilterEvent {
  final int branchId;
  final String token;

  ViolationFilterBranchIdUpdated({this.branchId, this.token});
  @override
  String toString() =>
      'ViolationFilterBranchIdUpdated { BranchId: $branchId  }';
}

class ViolationFilterRegulationUpdated extends ViolationFilterEvent {
  final int regulationId;
  final String token;

  ViolationFilterRegulationUpdated({this.regulationId, this.token});
  @override
  String toString() =>
      'ViolationFilterRegulationUpdated { RegulationId: $regulationId  }';
}

class ViolationFilterStatusUpdated extends ViolationFilterEvent {
  final String status;
  final String token;

  ViolationFilterStatusUpdated({this.status, this.token});
  @override
  String toString() => 'ViolationFilterStatusUpdated { Status: $status  }';
}

class ViolationFilterMonthUpdated extends ViolationFilterEvent {
  final DateTime month;
  final String token;

  ViolationFilterMonthUpdated({this.month, this.token});
  @override
  String toString() => 'ViolationFilterStatusUpdated { Month: $month  }';
}
