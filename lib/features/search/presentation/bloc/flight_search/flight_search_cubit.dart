import 'package:flutter/material.dart';
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

  final ScrollController scrollController = ScrollController();

  FlightSearchCubit(this.useCase) : super(FlightSearchState()) {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          !state.loading &&
          state.hasMore) {
        loadNextPage();
      }
    });
  }

  FlightEntity? selectedFlightEntity;

  void selectFlight(FlightEntity flightEntity) {
    selectedFlightEntity = flightEntity;
    emit(state);
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }

  Future<void> getFlights({
    SearchParams? params,
    bool forceRefresh = false,
  }) async {
    if (state.loading || !state.hasMore) return;

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
      await Future.delayed(const Duration(seconds: 2));

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

  Future<void> refreshHotels() async {
    _params = _params.copyWith(page: 1);
    emit(FlightSearchState(loading: true)); // reset state
    try {
      final res = await useCase(_params);
      emit(
        state.copyWith(
          loading: false,
          items: res.items,
          page: res.page,
          hasMore: res.page * res.perPage < res.total,
        ),
      );
    } catch (e) {
      emit(FlightSearchState(loading: false, error: e.toString()));
    }
  }
}
