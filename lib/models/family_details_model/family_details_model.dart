import 'package:json_annotation/json_annotation.dart';

part 'family_details_model.g.dart';

@JsonSerializable()
class FamilyDetailsModel {
  final String imageUrl, name, number, relation;

  const FamilyDetailsModel({
    required this.imageUrl,
    required this.name,
    required this.number,
    required this.relation,
  });

  factory FamilyDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$FamilyDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FamilyDetailsModelToJson(this);
}
