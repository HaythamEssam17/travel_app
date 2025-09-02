import '../../../domain/entites/hotel_entity.dart';

class HotelSearchState {
  final bool loading;
  final List<HotelEntity> items;
  final int page;
  final bool hasMore;
  final String? error;

  HotelSearchState({
    this.loading = false,
    this.items = const [],
    this.page = 1,
    this.hasMore = true,
    this.error,
  });

  HotelSearchState copyWith({
    bool? loading,
    List<HotelEntity>? items,
    int? page,
    bool? hasMore,
    String? error,
  }) {
    return HotelSearchState(
      loading: loading ?? this.loading,
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }
}

//
// class HotelSearchInit extends HotelSearchState {}
//
// class HotelSearchLoading extends HotelSearchState {}
//
// class HotelSearchLoadingMore extends HotelSearchState {}
//
// class HotelSearchEmpty extends HotelSearchState {}
//
// class HotelSearchSuccess extends HotelSearchState {}
//
// class HotelSearchSuccessMoreDate extends HotelSearchState {}
//
// class HotelSearchErrorMoreDate extends HotelSearchState {
//   final String error;
//
//   HotelSearchErrorMoreDate(this.error);
// }
