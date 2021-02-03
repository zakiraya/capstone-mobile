import 'package:formz/formz.dart';

enum ReportDescriptionValidationError { empty }

class ReportBranch extends FormzInput<int, ReportDescriptionValidationError> {
  const ReportBranch.pure() : super.pure(-1);
  const ReportBranch.dirty([int value = -1]) : super.dirty(value);

  @override
  ReportDescriptionValidationError validator(int value) {
    return value > -1 ? null : ReportDescriptionValidationError.empty;
  }
}
