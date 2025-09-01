import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/search_params.dart';
import '../../../domain/entites/flight_entity.dart';
import '../../../domain/usecase/search_flights.dart';
import 'flight_search_states.dart';

@Injectable()
class FlightSearchCubit extends Cubit<FlightSearchState> {
  final SearchFlights useCase;
  SearchParams _params = SearchParams();

  FlightSearchCubit(this.useCase) : super(FlightSearchState());

  Future<void> search({SearchParams? params, bool forceRefresh = false}) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      _params = params ?? _params.copyWith(page: 1);
      final res = await useCase.call(_params);
      emit(
        state.copyWith(
          loading: false,
          items: res.items,
          page: res.page,
          hasMore: res.page * res.perPage < res.total,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> loadNextPage() async {
    if (!state.hasMore || state.loading) return;
    final next = state.page + 1;
    emit(state.copyWith(loading: true));
    try {
      _params = _params.copyWith(page: next);
      final res = await useCase(_params);
      final all = List<FlightEntity>.from(state.items)..addAll(res.items);
      emit(
        state.copyWith(
          loading: false,
          items: all,
          page: res.page,
          hasMore: res.page * res.perPage < res.total,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  void applyFilters({
    double? minPrice,
    double? maxPrice,
    List<String>? airlines,
    double? minRating,
  }) {
    _params = _params.copyWith(
      minPrice: minPrice,
      maxPrice: maxPrice,
      airlines: airlines,
      minRating: minRating,
      page: 1,
    );
    search(params: _params);
  }
}
