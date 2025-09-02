import '../../../../core/enums/booking_enum.dart';
import '../../domain/entities/booking.dart';

class BookingState {
  final bool loading;
  final BookingEntity? booking;
  final BookingStatus? liveStatus;
  final String? error;

  // UI form fields (passenger / guest)
  final Map<String, dynamic> form;

  BookingState({
    this.loading = false,
    this.booking,
    this.liveStatus,
    this.error,
    this.form = const {},
  });

  BookingState copyWith({
    bool? loading,
    BookingEntity? booking,
    BookingStatus? liveStatus,
    String? error,
    Map<String, dynamic>? form,
  }) {
    return BookingState(
      loading: loading ?? this.loading,
      booking: booking ?? this.booking,
      liveStatus: liveStatus ?? this.liveStatus,
      error: error,
      form: form ?? this.form,
    );
  }
}
