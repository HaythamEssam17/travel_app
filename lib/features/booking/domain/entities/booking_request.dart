class BookingRequest {
  final String itemId;
  final String itemType;
  final String userId;
  final Map<String, dynamic> details;

  BookingRequest({
    required this.itemId,
    required this.itemType,
    required this.userId,
    required this.details,
  });
}
