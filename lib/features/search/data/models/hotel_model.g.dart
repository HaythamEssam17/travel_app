// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HotelModelAdapter extends TypeAdapter<HotelModel> {
  @override
  final int typeId = 21;

  @override
  HotelModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HotelModel();
  }

  @override
  void write(BinaryWriter writer, HotelModel obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotelModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelModel _$HotelModelFromJson(Map<String, dynamic> json) => HotelModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  pricePerNight: (json['pricePerNight'] as num?)?.toDouble(),
  city: json['city'] as String?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$HotelModelToJson(HotelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'pricePerNight': instance.pricePerNight,
      'city': instance.city,
      'imageUrl': instance.imageUrl,
    };
