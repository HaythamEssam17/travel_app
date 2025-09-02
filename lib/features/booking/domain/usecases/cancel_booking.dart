import 'package:injectable/injectable.dart';

import '../repositories/booking_repo.dart';

@Injectable()
class CancelBooking {
  final IBookingRepository repo;

  CancelBooking(this.repo);

  Future<void> call(String bookingId) => repo.cancelBooking(bookingId);
}
