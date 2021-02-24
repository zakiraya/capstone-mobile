part of 'violation_list_bloc.dart';

class ViolationListState extends Equatable {
  const ViolationListState({
    this.violations,
    this.status = FormzStatus.pure,
  });

  final List<Violation> violations;
  final FormzStatus status;

  ViolationListState copyWith({
    FormzStatus status,
    List<Violation> violations,
  }) {
    return ViolationListState(
      violations: violations ?? this.violations,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        violations,
        status,
      ];
}
