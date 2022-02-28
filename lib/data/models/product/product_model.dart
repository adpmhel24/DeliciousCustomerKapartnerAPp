import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  late int id;

  @JsonKey(name: "item_code")
  late String itemCode;

  @JsonKey(name: "item_name")
  late String itemName;
  String? uom;

  @JsonKey(name: "item_group")
  String? itemGroup;
  double? price;

  bool isSelected = false;

  @JsonKey(name: "image_url")
  String? imageUrl;

  ProductModel({
    required this.id,
    required this.itemCode,
    required this.itemName,
    this.uom,
    this.itemGroup,
    this.price,
    this.isSelected = false,
    this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
