import 'package:freezed_annotation/freezed_annotation.dart';

part 'ifo.g.dart';
part 'ifo.freezed.dart';

@freezed
class Ifo with _$Ifo {
  factory Ifo({required int id, required String name}) = _Ifo;

  factory Ifo.fromJson(Map<String, dynamic> json) => _$IfoFromJson(json);
}
