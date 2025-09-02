import 'package:injectable/injectable.dart';

import '../../../../core/enums/booking_enum.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_request.dart';
import '../../domain/repositories/booking_repo.dart';
import '../datasources/booking_remote_ds.dart';

@Injectable(as: IBookingRepository)
class BookingRepositoryImpl implements IBookingRepository {
  final BookingRemoteDataSource remote;

  BookingRepositoryImpl(this.remote);

  @override
  Future<BookingEntity> createBooking(BookingRequest request) async {
    final res = await remote.createBooking({
      'itemId': request.itemId,
      'itemType': request.itemType,
      'userId': request.userId,
      'details': request.details,
    });

    return BookingEntity(
      id: res['id'] as String,
      itemId: request.itemId,
      itemType: request.itemType,
      userId: request.userId,
      status: _mapStatus(res['status'] as String),
      createdAt: DateTime.parse(res['createdAt'] as String),
      details: request.details,
    );
  }

  @override
  Stream<BookingStatus> watchBookingStatus(String bookingId) {
    return remote.watchBookingStatus(bookingId).map(_mapStatus);
  }

  @override
  Future<void> cancelBooking(String bookingId) =>
      remote.cancelBooking(bookingId);

  BookingStatus _mapStatus(String s) {
    switch (s) {
      case 'initiated':
        return BookingStatus.initiated;
      case 'processing':
        return BookingStatus.processing;
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'failed':
        return BookingStatus.failed;
      case 'cancelled':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.failed;
    }
  }
}
