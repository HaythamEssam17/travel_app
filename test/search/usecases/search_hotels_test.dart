import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:travel_app/features/search/data/models/paged_response.dart';
import 'package:travel_app/features/search/data/models/search_params.dart';
import 'package:travel_app/features/search/domain/entites/hotel_entity.dart';
import 'package:travel_app/features/search/domain/repository/search_repository.dart';
import 'package:travel_app/features/search/domain/usecase/hotel_search.dart';

class _MockRepo extends Mock implements ISearchRepository {}

void main() {
  late _MockRepo mockRepo;
  late SearchHotels usecase;

  setUp(() {
    mockRepo = _MockRepo();
    usecase = SearchHotels(mockRepo);
  });

  test('should forward call to repository and return paged hotels', () async {
    final params = SearchParams(page: 1, perPage: 10);
    final hotels = [
      HotelEntity(
        id: 'h1',
        name: 'H1',
        rating: 4.0,
        pricePerNight: 100,
        city: 'Cairo',
        imageUrl: '',
      ),
    ];

    when(() => mockRepo.searchHotels(params)).thenAnswer(
      (_) async => PagedResponse<HotelEntity>(
        page: 1,
        perPage: 10,
        total: 1,
        items: hotels,
      ),
    );

    final res = await usecase.call(params);

    expect(res.items.length, 1);
    verify(() => mockRepo.searchHotels(params)).called(1);
  });
}
