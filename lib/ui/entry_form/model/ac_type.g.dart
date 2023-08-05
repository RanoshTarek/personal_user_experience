// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ac_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcType _$AcTypeFromJson(Map<String, dynamic> json) => AcType(
      id: json['id'] as String,
      name: json['name'] as String,
      acReq: (json['acReq'] as List<dynamic>)
          .map((e) => AcReq.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AcTypeToJson(AcType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'acReq': instance.acReq,
    };
