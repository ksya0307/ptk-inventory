import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  //для представления немодифицированного ввода формы
  const Username.pure() : super.pure('');

  //для представления модифицированного ввода формы, тоесть когда ввели что-то
  const Username.dirty([String value = '']) : super.dirty(value);

  //валидация что username не пустое(можно любую)
  @override
  UsernameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : UsernameValidationError.empty;
  }
}
