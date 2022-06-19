import 'package:formz/formz.dart';

enum CommentValidationError { empty }

class Comment extends FormzInput<String, CommentValidationError> {
  const Comment.pure() : super.pure('');

  const Comment.dirty([String value = '']) : super.dirty(value);

  @override
  CommentValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : CommentValidationError.empty;
  }
}
