import 'dart:async';

import 'package:injectable/injectable.dart';

abstract class BookingRemoteDataSource {
  Future<Map<String, dynamic>> createBooking(Map<String, dynamic> body);

  Stream<String> watchBookingStatus(String bookingId);

  Future<void> cancelBooking(String bookingId);
}

@Injectable(as: BookingRemoteDataSource)
class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  @override
  Future<Map<String, dynamic>> createBooking(Map<String, dynamic> body) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final bookingId = DateTime.now().millisecondsSinceEpoch.toString();
    return {
      'id': bookingId,
      'status': 'initiated',
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  // محاكاة WebSocket/Stream: ترقية الحالة تدريجيًا
  @override
  Stream<String> watchBookingStatus(String bookingId) {
    // initiated -> processing -> confirmed OR failed
    final controller = StreamController<String>();
    Future<void>.delayed(const Duration(milliseconds: 400), () {
      controller.add('initiated');
    });
    Future<void>.delayed(const Duration(seconds: 1), () {
      controller.add('processing');
    });
    Future<void>.delayed(const Duration(seconds: 2), () {
      controller.add('confirmed');
      controller.close();
    });
    return controller.stream;
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
