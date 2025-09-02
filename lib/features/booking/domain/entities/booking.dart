import '../../../../core/enums/booking_enum.dart';

class BookingEntity {
  final String id;
  final String itemId;
  final String itemType;
  final String userId;
  final BookingStatus status;
  final DateTime createdAt;
  final Map<String, dynamic> details;

  BookingEntity({
    required this.id,
    required this.itemId,
    required this.itemType,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.details,
  });

  BookingEntity copyWith({
    BookingStatus? status,
    Map<String, dynamic>? details,
  }) {
    return BookingEntity(
      id: id,
      itemId: itemId,
      itemType: itemType,
      userId: userId,
      status: status ?? this.status,
      createdAt: createdAt,
      details: details ?? this.details,
    );
  }
}
