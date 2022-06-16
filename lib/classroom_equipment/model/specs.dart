import 'package:formz/formz.dart';

enum SpecsValidationError { empty }

class Specs extends FormzInput<String, SpecsValidationError> {
  const Specs.pure() : super.pure('');

  const Specs.dirty([String value = '']) : super.dirty(value);

  @override
  SpecsValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : SpecsValidationError.empty;
  }
}
