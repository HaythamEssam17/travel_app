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

  HotelSearchCubit(this.useCase) : super(HotelSearchState());

  Future<void> search({SearchParams? params}) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      _params = params ?? _params.copyWith(page: 1);
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

  void applyFilters({double? minPrice, double? maxPrice, double? minRating}) {
    _params = _params.copyWith(
      minPrice: minPrice,
      maxPrice: maxPrice,
      minRating: minRating,
      page: 1,
    );
    search(params: _params);
  }
}
