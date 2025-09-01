import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travel_app/features/search/domain/entites/flight_entity.dart';

part 'flight_model.g.dart';

@HiveType(typeId: 20)
@JsonSerializable()
class FlightModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? airline;
  @HiveField(2)
  final double? price;
  @HiveField(3)
  final String? departAt; // iso string
  @HiveField(4)
  final String? arriveAt;
  @HiveField(5)
  final int? stops;

  FlightModel({
    this.id,
    this.airline,
    this.price,
    this.departAt,
    this.arriveAt,
    this.stops,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) =>
      _$FlightModelFromJson(json);

  Map<String, dynamic> toJson() => _$FlightModelToJson(this);

  FlightEntity toEntity() => FlightEntity(
    id: id ?? '',
    airline: airline ?? '',
    price: price ?? 0.0,
    departAt: departAt == null ? DateTime.now() : DateTime.parse(departAt!),
    arriveAt: arriveAt == null ? DateTime.now() : DateTime.parse(arriveAt!),
    stops: stops ?? 0,
  );

  static FlightModel fromEntity(FlightEntity f) => FlightModel(
    id: f.id,
    airline: f.airline,
    price: f.price,
    departAt: f.departAt.toIso8601String(),
    arriveAt: f.arriveAt.toIso8601String(),
    stops: f.stops,
  );
}
