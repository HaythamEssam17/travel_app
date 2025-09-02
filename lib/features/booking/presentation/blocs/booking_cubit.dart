import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/booking_enum.dart';
import '../../domain/entities/booking_request.dart';
import '../../domain/usecases/cancel_booking.dart';
import '../../domain/usecases/create_booking.dart';
import '../../domain/usecases/watch_booking_status.dart';
import 'booking_states.dart';

@Injectable()
class BookingCubit extends Cubit<BookingState> {
  final CreateBooking createBookingUC;
  final WatchBookingStatus watchStatusUC;
  final CancelBooking cancelBookingUC;

  StreamSubscription<BookingStatus>? _sub;

  BookingCubit(this.createBookingUC, this.watchStatusUC, this.cancelBookingUC)
    : super(BookingState());

  void selectItem({
    required String itemId,
    required String itemType,
    required String userId,
  }) {
    emit(
      BookingState(
        loading: false,
        form: {
          'itemId': itemId,
          'itemType': itemType,
          'userId': userId,
          'passengers': <Map<String, dynamic>>[],
          'guests': <Map<String, dynamic>>[],
        },
      ),
    );
  }

  void addPassenger(Map<String, dynamic> p) {
    final passengers = List<Map<String, dynamic>>.from(
      state.form['passengers'] ?? [],
    );
    passengers.add(p);
    emit(state.copyWith(form: {...state.form, 'passengers': passengers}));
  }

  void addGuest(Map<String, dynamic> g) {
    final guests = List<Map<String, dynamic>>.from(state.form['guests'] ?? []);
    guests.add(g);
    emit(state.copyWith(form: {...state.form, 'guests': guests}));
  }

  Future<void> confirm() async {
    try {
      emit(state.copyWith(loading: true, error: null));
      final req = BookingRequest(
        itemId: state.form['itemId'],
        itemType: state.form['itemType'],
        userId: state.form['userId'],
        details: {
          'passengers': state.form['passengers'],
          'guests': state.form['guests'],
        },
      );
      final booking = await createBookingUC(req);
      emit(
        state.copyWith(
          loading: false,
          booking: booking,
          liveStatus: booking.status,
        ),
      );
      _listenStatus(booking.id);
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  String label() {
    switch (state.liveStatus) {
      case BookingStatus.initiated:
        return 'Initiated';
      case BookingStatus.processing:
        return 'Processing...';
      case BookingStatus.confirmed:
        return 'Confirmed ✅';
      case BookingStatus.failed:
        return 'Failed ❌';
      case BookingStatus.cancelled:
        return 'Cancelled';
      default:
        return '...';
    }
  }

  void _listenStatus(String bookingId) {
    _sub?.cancel();
    _sub = watchStatusUC(bookingId).listen(
      (status) {
        emit(state.copyWith(liveStatus: status));
      },
      onError: (e) {
        emit(state.copyWith(error: e.toString()));
      },
    );
  }

  Future<void> cancel() async {
    if (state.booking == null) return;
    await cancelBookingUC(state.booking!.id);
    emit(state.copyWith(liveStatus: BookingStatus.cancelled));
    await _sub?.cancel();
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
