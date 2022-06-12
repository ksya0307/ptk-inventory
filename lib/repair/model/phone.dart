import 'package:formz/formz.dart';

enum PhoneValidationError { empty }

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');

  const Phone.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return PhoneValidationError.empty;
    } else if (value.length < 15) {
      return PhoneValidationError.empty;
    }
    return null;
  }
}
