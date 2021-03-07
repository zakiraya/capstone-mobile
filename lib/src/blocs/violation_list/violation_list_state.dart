part of 'violation_list_bloc.dart';

class ViolationListState extends Equatable {
  const ViolationListState({
    this.violations,
    this.status = FormzStatus.pure,
    this.violationBranch = const ViolationBranch.pure(),
  });

  final List<Violation> violations;
  final FormzStatus status;
  final ViolationBranch violationBranch;

  ViolationListState copyWith({
    FormzStatus status,
    List<Violation> violations,
    ViolationBranch violationBranch,
  }) {
    return ViolationListState(
      violations: violations ?? this.violations,
      status: status ?? this.status,
      violationBranch: violationBranch ?? this.violationBranch,
    );
  }

  @override
  List<Object> get props => [
        violations,
        status,
        violationBranch,
      ];
}
