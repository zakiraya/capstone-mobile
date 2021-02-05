import 'package:formz/formz.dart';

enum ViolationRegulationValidationError { empty }

class ViolationRegulation
    extends FormzInput<int, ViolationRegulationValidationError> {
  const ViolationRegulation.pure() : super.pure(-1);
  const ViolationRegulation.dirty([int value = -1]) : super.dirty(value);

  @override
  ViolationRegulationValidationError validator(int value) {
    return value > -1 ? null : ViolationRegulationValidationError.empty;
  }
}
