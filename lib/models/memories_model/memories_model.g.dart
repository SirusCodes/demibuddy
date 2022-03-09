// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemoriesModel _$MemoriesModelFromJson(Map<String, dynamic> json) =>
    MemoriesModel(
      image: json['image'] as String,
      description: json['description'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$MemoriesModelToJson(MemoriesModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'description': instance.description,
      'title': instance.title,
    };
