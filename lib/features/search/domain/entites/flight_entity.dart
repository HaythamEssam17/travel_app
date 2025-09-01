class FlightEntity {
  final String id;
  final String airline;
  final double price;
  final DateTime departAt;
  final DateTime arriveAt;
  final int stops;

  FlightEntity({
    required this.id,
    required this.airline,
    required this.price,
    required this.departAt,
    required this.arriveAt,
    required this.stops,
  });
}
