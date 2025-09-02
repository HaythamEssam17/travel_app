import 'package:injectable/injectable.dart';

import '../../../../core/enums/booking_enum.dart';
import '../repositories/booking_repo.dart';

@Injectable()
class WatchBookingStatus {
  final IBookingRepository repo;

  WatchBookingStatus(this.repo);

  Stream<BookingStatus> call(String bookingId) =>
      repo.watchBookingStatus(bookingId);
}
