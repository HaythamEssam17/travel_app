import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travel_app/features/search/domain/entites/hotel_entity.dart';

part 'hotel_model.g.dart';

@HiveType(typeId: 21)
@JsonSerializable()
class HotelModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final double? rating;
  @HiveField(3)
  final double? pricePerNight;
  @HiveField(4)
  final String? city;
  @HiveField(5)
  final String? imageUrl;

  HotelModel({
    this.id,
    this.name,
    this.rating,
    this.pricePerNight,
    this.city,
    this.imageUrl,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) =>
      _$HotelModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelModelToJson(this);

  HotelEntity toEntity() => HotelEntity(
    id: id ?? '',
    name: name ?? '',
    rating: rating ?? 0.0,
    pricePerNight: pricePerNight ?? 0.0,
    city: city ?? '',
    imageUrl: imageUrl ?? '',
  );

  static HotelModel fromEntity(HotelEntity h) => HotelModel(
    id: h.id,
    name: h.name,
    rating: h.rating,
    pricePerNight: h.pricePerNight,
    city: h.city,
    imageUrl: h.imageUrl,
  );
}
