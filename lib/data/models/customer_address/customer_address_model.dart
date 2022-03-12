import 'package:json_annotation/json_annotation.dart';

part 'customer_address_model.g.dart';

@JsonSerializable()
class CustomerAddressModel {
  static toNull(_) => null;
  @JsonKey(toJson: toNull, includeIfNull: false)
  String? uid;

  @JsonKey(toJson: toNull, includeIfNull: false)
  int? id;

  @JsonKey(name: "street_address")
  String? streetAddress;

  @JsonKey(name: "city_municipality")
  String? cityMunicipality;

  String? brgy;

  @JsonKey(name: "other_details")
  String? otherDetails;

  @JsonKey(name: "is_default", includeIfNull: false)
  bool? isDefault;

  @JsonKey(name: "delivery_fee", toJson: toNull, includeIfNull: false)
  double? deliveryFee;

  CustomerAddressModel({
    this.id,
    this.uid = '',
    this.streetAddress,
    this.cityMunicipality,
    this.brgy,
    this.otherDetails,
    this.isDefault = false,
    this.deliveryFee = 0.00,
  });

  factory CustomerAddressModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerAddressModelToJson(this);
}
