import 'package:kapartner_app/data/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel extends ProductModel {
  double quantity;
  double discprcnt;

  @JsonKey(name: "disc_amount")
  double discAmount;
  double total;

  CartItemModel({
    required id,
    required itemCode,
    required itemName,
    required this.quantity,
    this.discprcnt = 0.00,
    this.discAmount = 0.00,
    required this.total,
  }) : super(id: id, itemCode: itemCode, itemName: itemName);

  Map<String, dynamic> checkOutData() => <String, dynamic>{
        'item_code': itemCode,
        'unit_price': price,
        'quantity': quantity,
        'uom': uom,
        'disc_amount': discAmount,
        'discprcnt': discprcnt
      };

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
