// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HubModel _$HubModelFromJson(Map<String, dynamic> json) => HubModel(
      id: json['id'] as int,
      whsecode: json['whsecode'] as String,
      whsename: json['whsename'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$HubModelToJson(HubModel instance) => <String, dynamic>{
      'id': instance.id,
      'whsecode': instance.whsecode,
      'whsename': instance.whsename,
      'address': instance.address,
    };
