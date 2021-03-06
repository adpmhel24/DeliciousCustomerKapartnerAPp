// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      id: json['id'],
      itemCode: json['item_code'],
      itemName: json['item_name'],
      quantity: (json['quantity'] as num).toDouble(),
      discprcnt: (json['discprcnt'] as num?)?.toDouble() ?? 0.00,
      discAmount: (json['disc_amount'] as num?)?.toDouble() ?? 0.00,
      total: (json['total'] as num).toDouble(),
    )
      ..uom = json['uom'] as String?
      ..itemGroup = json['item_group'] as String?
      ..price = (json['price'] as num?)?.toDouble()
      ..isSelected = json['isSelected'] as bool
      ..imageUrl = json['image_url'] as String?
      ..isAvailable = json['is_available'] as bool?;

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item_code': instance.itemCode,
      'item_name': instance.itemName,
      'uom': instance.uom,
      'item_group': instance.itemGroup,
      'price': instance.price,
      'isSelected': instance.isSelected,
      'image_url': instance.imageUrl,
      'is_available': instance.isAvailable,
      'quantity': instance.quantity,
      'discprcnt': instance.discprcnt,
      'disc_amount': instance.discAmount,
      'total': instance.total,
    };
