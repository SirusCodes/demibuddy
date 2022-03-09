// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyDetailsModel _$FamilyDetailsModelFromJson(Map<String, dynamic> json) =>
    FamilyDetailsModel(
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      relation: json['relation'] as String,
    );

Map<String, dynamic> _$FamilyDetailsModelToJson(FamilyDetailsModel instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'number': instance.number,
      'relation': instance.relation,
    };
