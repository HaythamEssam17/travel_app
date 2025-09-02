import 'package:injectable/injectable.dart';

import '../entities/booking.dart';
import '../entities/booking_request.dart';
import '../repositories/booking_repo.dart';

@Injectable()
class CreateBooking {
  final IBookingRepository repo;

  CreateBooking(this.repo);

  Future<BookingEntity> call(BookingRequest req) => repo.createBooking(req);
}
