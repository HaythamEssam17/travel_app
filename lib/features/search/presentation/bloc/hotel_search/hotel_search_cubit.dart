import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_app/features/search/domain/entites/hotel_entity.dart';

import '../../../data/models/search_params.dart';
import '../../../domain/usecase/hotel_search.dart';
import 'hotel_search_states.dart';

@Injectable()
class HotelSearchCubit extends Cubit<HotelSearchState> {
  final SearchHotels useCase;
  SearchParams _params = SearchParams();

  final ScrollController scrollController = ScrollController();

  HotelSearchCubit(this.useCase) : super(HotelSearchState()) {
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

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }

  Future<void> getHotels({
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

      final all = List<HotelEntity>.from(state.items)..addAll(res.items);

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
    emit(HotelSearchState(loading: true)); // reset state
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
      emit(HotelSearchState(loading: false, error: e.toString()));
    }
  }
}
