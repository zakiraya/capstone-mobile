import 'package:formz/formz.dart';

enum ViolationBranchValidationError { empty }

class ViolationBranch extends FormzInput<int, ViolationBranchValidationError> {
  const ViolationBranch.pure() : super.pure(-1);
  const ViolationBranch.dirty([int value = -1]) : super.dirty(value);

  @override
  ViolationBranchValidationError validator(int value) {
    return value > -1 ? null : ViolationBranchValidationError.empty;
  }
}
