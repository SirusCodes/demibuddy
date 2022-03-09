import 'package:json_annotation/json_annotation.dart';

part 'memories_model.g.dart';

@JsonSerializable()
class MemoriesModel {
  final String imageUrl, description, title;

  const MemoriesModel({
    required this.imageUrl,
    required this.description,
    required this.title,
  });

  factory MemoriesModel.fromJson(Map<String, dynamic> json) =>
      _$MemoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemoriesModelToJson(this);
}
