part of 'violation_filter_bloc.dart';

class ViolationFilterState extends Equatable {
  final Filter filter;

  ViolationFilterState({this.filter});

  ViolationFilterState copyWith({
    Filter filter,
  }) {
    return ViolationFilterState(
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'ViolationFilterState: { $filter }';
}

// class ViolationFilterInProgress extends ViolationFilterState {}

// class ViolationFilterSucess extends ViolationFilterState {
//   final List<Violation> filteredViolations;
//   final  activeFilter;

//   ViolationFilterSucess(this.filteredViolations, this.activeFilter);

//   @override
//   List<Object> get props => [filteredViolations, activeFilter];

//   @override
//   String toString() {
//     return 'FilteredTodosLoadSuccess { filteredTodos: $filteredViolations, activeFilter: $activeFilter }';
//   }
// }
// class ViolationFilterSucess extends ViolationFilterState {}
