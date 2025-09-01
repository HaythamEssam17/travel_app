// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlightModelAdapter extends TypeAdapter<FlightModel> {
  @override
  final int typeId = 20;

  @override
  FlightModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlightModel();
  }

  @override
  void write(BinaryWriter writer, FlightModel obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlightModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightModel _$FlightModelFromJson(Map<String, dynamic> json) => FlightModel(
  id: json['id'] as String?,
  airline: json['airline'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  departAt: json['departAt'] as String?,
  arriveAt: json['arriveAt'] as String?,
  stops: (json['stops'] as num?)?.toInt(),
);

Map<String, dynamic> _$FlightModelToJson(FlightModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'airline': instance.airline,
      'price': instance.price,
      'departAt': instance.departAt,
      'arriveAt': instance.arriveAt,
      'stops': instance.stops,
    };
