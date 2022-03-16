import 'package:json_annotation/json_annotation.dart';

part 'hub_model.g.dart';

@JsonSerializable()
class HubModel {
  int id;
  String whsecode;
  String whsename;
  String address;

  HubModel({
    required this.id,
    required this.whsecode,
    required this.whsename,
    required this.address,
  });

  factory HubModel.fromJson(Map<String, dynamic> json) =>
      _$HubModelFromJson(json);

  Map<String, dynamic> toJson() => _$HubModelToJson(this);
}
