import 'package:json_annotation/json_annotation.dart';

part 'family_details_model.g.dart';

@JsonSerializable()
class FamilyDetailsModel {
  final String image, name, phone, relation, email;

  const FamilyDetailsModel({
    required this.image,
    required this.email,
    required this.name,
    required this.phone,
    required this.relation,
  });

  factory FamilyDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$FamilyDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FamilyDetailsModelToJson(this);
}
