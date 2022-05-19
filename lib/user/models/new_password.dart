import 'package:formz/formz.dart';

enum PasswordValidationError { empty, short }

class NewPassword extends FormzInput<String, PasswordValidationError> {
  const NewPassword.pure() : super.pure('');

  const NewPassword.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    if (value?.isEmpty == true) {
      return PasswordValidationError.empty;
    } else if (value!.length < 8) {
      return PasswordValidationError.short;
    }
    return null;
  }
}
