import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/common/model/user.dart';

part 'user_result.g.dart';

@JsonSerializable()
class UserResult {
  final List<User> result;
  const UserResult({required this.result});
  factory UserResult.fromJson(Map<String, dynamic> json) =>
      _$UserResultFromJson(json);
}
