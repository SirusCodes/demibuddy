// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemoriesModel _$MemoriesModelFromJson(Map<String, dynamic> json) =>
    MemoriesModel(
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$MemoriesModelToJson(MemoriesModel instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'title': instance.title,
    };
