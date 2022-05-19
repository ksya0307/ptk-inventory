import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ptk_inventory/ifo/model/ifo.dart';

part 'ifo_result.g.dart';
part 'ifo_result.freezed.dart';

@freezed
class IfoResult with _$IfoResult {
  factory IfoResult({
    @Default([]) List<Ifo> result,
  }) = _IfoResult;

  factory IfoResult.fromJson(Map<String, dynamic> json) =>
      _$IfoResultFromJson(json);
}
