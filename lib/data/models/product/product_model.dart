import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  static toNull(_) => null;

  int id;

  @JsonKey(name: "item_code")
  String itemCode;

  @JsonKey(name: "item_name")
  String itemName;
  String? uom;

  @JsonKey(name: "item_group")
  String? itemGroup;
  double? price;

  bool isSelected = false;

  @JsonKey(name: "image_url")
  String? imageUrl;

  @JsonKey(name: "is_available")
  bool? isAvailable;

  ProductModel({
    required this.id,
    required this.itemCode,
    required this.itemName,
    this.uom,
    this.itemGroup,
    this.price,
    this.isSelected = false,
    this.imageUrl,
    this.isAvailable,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
