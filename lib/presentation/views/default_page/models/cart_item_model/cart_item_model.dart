import 'package:kapartner_app/data/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel extends ProductModel {
  double quantity;
  double total;

  CartItemModel({
    required id,
    required itemCode,
    required itemName,
    required this.quantity,
    required this.total,
  }) : super(id: id, itemCode: itemCode, itemName: itemName);

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
