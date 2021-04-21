import 'package:json_annotation/json_annotation.dart';

part 'stat.g.dart';

@JsonSerializable(explicitToJson: true)
class Stat {
  const Stat(
    this.baseStat,
    this.effort,
    this.stat
  );

  @JsonKey(name: 'base_stat')
  final int baseStat;

  final int effort;

  final Map stat;

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);

  Map<String, dynamic> toJson() => _$StatToJson(this);
}
