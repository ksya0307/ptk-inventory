import 'package:formz/formz.dart';

enum NumberValidationError { empty }

class Number extends FormzInput<String, NumberValidationError> {
  const Number.pure() : super.pure('');

  const Number.dirty([String value = '']) : super.dirty(value);

  @override
  NumberValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : NumberValidationError.empty;
  }
}
