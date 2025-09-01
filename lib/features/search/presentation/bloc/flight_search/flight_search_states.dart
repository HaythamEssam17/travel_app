import 'package:travel_app/features/search/domain/entites/flight_entity.dart';

class FlightSearchState {
  final bool loading;
  final List<FlightEntity> items;
  final int page;
  final bool hasMore;
  final String? error;

  FlightSearchState({
    this.loading = false,
    this.items = const [],
    this.page = 1,
    this.hasMore = true,
    this.error,
  });

  FlightSearchState copyWith({
    bool? loading,
    List<FlightEntity>? items,
    int? page,
    bool? hasMore,
    String? error,
  }) {
    return FlightSearchState(
      loading: loading ?? this.loading,
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }
}
