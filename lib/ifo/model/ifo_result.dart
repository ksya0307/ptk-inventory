import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/ifo/model/ifo.dart';

part 'ifo_result.g.dart';

@JsonSerializable()
class IfoResult extends Equatable {
  final List<Ifo> result;
  const IfoResult({required this.result});

  factory IfoResult.fromJson(Map<String, dynamic> json) =>
      _$IfoResultFromJson(json);

  @override
  List<Object?> get props => [result];
}
