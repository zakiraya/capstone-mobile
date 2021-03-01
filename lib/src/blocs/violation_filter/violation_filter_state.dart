part of 'violation_filter_bloc.dart';

abstract class ViolationFilterState extends Equatable {
  const ViolationFilterState();

  @override
  List<Object> get props => [];
}

class ViolationFilterInProgress extends ViolationFilterState {}

class ViolationFilterSucess extends ViolationFilterState {
  final List<Violation> filteredViolations;
  final String activeFilter;

  ViolationFilterSucess(this.filteredViolations, this.activeFilter);

  @override
  List<Object> get props => [filteredViolations, activeFilter];

  @override
  String toString() {
    return 'FilteredTodosLoadSuccess { filteredTodos: $filteredViolations, activeFilter: $activeFilter }';
  }
}