// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyDetailsModel _$FamilyDetailsModelFromJson(Map<String, dynamic> json) =>
    FamilyDetailsModel(
      image: json['image'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      relation: json['relation'] as String,
    );

Map<String, dynamic> _$FamilyDetailsModelToJson(FamilyDetailsModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'phone': instance.phone,
      'relation': instance.relation,
      'email': instance.email,
    };
