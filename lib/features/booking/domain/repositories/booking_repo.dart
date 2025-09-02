import '../../../../core/enums/booking_enum.dart';
import '../entities/booking.dart';
import '../entities/booking_request.dart';

abstract class IBookingRepository {
  Future<BookingEntity> createBooking(BookingRequest request);

  Stream<BookingStatus> watchBookingStatus(String bookingId);

  Future<void> cancelBooking(String bookingId);
}
