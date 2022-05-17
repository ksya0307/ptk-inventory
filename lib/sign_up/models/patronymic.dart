import 'package:formz/formz.dart';

enum PatronymicValidationError { empty, notEmpty }

class Patronymic extends FormzInput<String, PatronymicValidationError> {
  //для представления немодифицированного ввода формы
  const Patronymic.pure() : super.pure('');

  //для представления модифицированного ввода формы, тоесть когда ввели что-то
  const Patronymic.dirty([String value = '']) : super.dirty(value);

  //валидация что username не пустое(можно любую)
  @override
  PatronymicValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? PatronymicValidationError.notEmpty
        : PatronymicValidationError.empty;
  }
}
