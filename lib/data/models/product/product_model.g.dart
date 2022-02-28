// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as int,
      itemCode: json['item_code'] as String,
      itemName: json['item_name'] as String,
      uom: json['uom'] as String?,
      itemGroup: json['item_group'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      isSelected: json['isSelected'] as bool? ?? false,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item_code': instance.itemCode,
      'item_name': instance.itemName,
      'uom': instance.uom,
      'item_group': instance.itemGroup,
      'price': instance.price,
      'isSelected': instance.isSelected,
      'image_url': instance.imageUrl,
    };
