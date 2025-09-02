import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:travel_app/features/search/data/models/paged_response.dart';
import 'package:travel_app/features/search/domain/entites/hotel_entity.dart';
import 'package:travel_app/features/search/domain/usecase/hotel_search.dart';
import 'package:travel_app/features/search/presentation/bloc/hotel_search/hotel_search_cubit.dart';
import 'package:travel_app/features/search/presentation/bloc/hotel_search/hotel_search_states.dart';

class _MockUsecase extends Mock implements SearchHotels {}

void main() {
  late _MockUsecase mockUsecase;
  late HotelSearchCubit cubit;

  setUp(() {
    mockUsecase = _MockUsecase();
    cubit = HotelSearchCubit(mockUsecase);
  });

  tearDown(() {
    cubit.close();
  });

  final hotels = [
    HotelEntity(
      id: 'h1',
      name: 'H1',
      rating: 4.0,
      pricePerNight: 50,
      city: 'C',
      imageUrl: '',
    ),
  ];

  blocTest<HotelSearchCubit, HotelSearchState>(
    'emits [loading, loaded] when getHotels success',
    build: () {
      when(() => mockUsecase.call(any())).thenAnswer(
        (_) async => PagedResponse<HotelEntity>(
          page: 1,
          perPage: 10,
          total: 1,
          items: hotels,
        ),
      );
      return cubit;
    },
    act: (c) => c.getHotels(),
    expect: () => [
      isA<HotelSearchState>().having((s) => s.loading, 'loading', true),
      isA<HotelSearchState>().having((s) => s.items.length, 'items', 1),
    ],
  );

  blocTest<HotelSearchCubit, HotelSearchState>(
    'loadNextPage appends items',
    build: () {
      when(() => mockUsecase.call(any())).thenAnswer(
        (_) async => PagedResponse<HotelEntity>(
          page: 1,
          perPage: 10,
          total: 20,
          items: hotels,
        ),
      );
      return cubit;
    },
    act: (c) async {
      await c.getHotels();

      when(
        () => mockUsecase.call(any(that: predicate((p) => p == 2))),
      ).thenAnswer(
        (_) async => PagedResponse<HotelEntity>(
          page: 2,
          perPage: 10,
          total: 20,
          items: hotels,
        ),
      );

      await c.loadNextPage();
    },

    expect: () => [
      // first call emits loading + loaded
      // then loadNextPage emits loading + loaded with 2 items
      isA<HotelSearchState>(),
      isA<HotelSearchState>(),
      isA<HotelSearchState>(),
      predicate<HotelSearchState>((s) => s.items.length == 2),
    ],
  );
}
