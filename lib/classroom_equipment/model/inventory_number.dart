import 'package:formz/formz.dart';

enum InventoryNumberValidationError { empty }

class InventoryNumber extends FormzInput<String, InventoryNumberValidationError> {
  const InventoryNumber.pure() : super.pure('');

  const InventoryNumber.dirty([String value = '']) : super.dirty(value);

  @override
  InventoryNumberValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : InventoryNumberValidationError.empty;
  }
}
