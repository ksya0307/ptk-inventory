import 'package:formz/formz.dart';

enum ProblemValidationError { empty }

class Problem extends FormzInput<String, ProblemValidationError> {
  const Problem.pure() : super.pure('');

  const Problem.dirty([String value = '']) : super.dirty(value);

  @override
  ProblemValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : ProblemValidationError.empty;
  }
}
