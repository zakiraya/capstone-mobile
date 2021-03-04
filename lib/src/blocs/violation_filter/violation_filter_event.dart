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
  final ViolationFilter filter;

  FilterUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdated { filter: $filter }';
}

class ViolationsUpdated extends ViolationFilterEvent {
  final List<Violation> violations;

  ViolationsUpdated(this.violations);
  @override
  List<Object> get props => [violations];

  @override
  String toString() => 'TodosUpdated { todos: $violations }';
}
