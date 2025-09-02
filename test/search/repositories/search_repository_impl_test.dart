import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:travel_app/core/services/hive_service.dart';
import 'package:travel_app/features/search/data/data_source/hotel_remote_ds.dart';
import 'package:travel_app/features/search/data/models/hotel_model.dart';
import 'package:travel_app/features/search/data/models/paged_response.dart';
import 'package:travel_app/features/search/data/models/search_params.dart';
import 'package:travel_app/features/search/data/repository/search_repository_impl.dart';

class _MockHotelRemote extends Mock implements HotelRemoteDataSource {}

class _MockCache extends Mock implements HiveServiceProvider {}

void main() {
  late _MockHotelRemote mockRemote;
  late _MockCache mockCache;
  late SearchRepositoryImpl repo;

  setUp(() {
    mockRemote = _MockHotelRemote();
    mockCache = _MockCache();
    repo = SearchRepositoryImpl(
      flightRemote: throw UnimplementedError(),
      hotelRemote: mockRemote,
    );
  });

  test('returns remote and caches when remote returns data', () async {
    final params = SearchParams(page: 1, perPage: 10);
    final model = HotelModel(
      id: 'h1',
      name: 'H',
      rating: 4,
      pricePerNight: 50,
      city: 'C',
      imageUrl: '',
    );
    final remoteResp = PagedResponse<HotelModel>(
      page: 1,
      perPage: 10,
      total: 1,
      items: [model],
    );

    when(
      () => mockRemote.searchHotels(params),
    ).thenAnswer((_) async => remoteResp);
    when(() => mockCache.saveHotels(any())).thenAnswer((_) async {});

    final res = await repo.searchHotels(params);

    expect(res.items.length, 1);
    verify(() => mockCache.saveHotels(any())).called(1);
  });

  test('falls back to cache when remote returns empty', () async {
    final params = SearchParams(page: 1, perPage: 10);
    final model = HotelModel(
      id: 'h1',
      name: 'H',
      rating: 4,
      pricePerNight: 50,
      city: 'C',
      imageUrl: '',
    );
    final remoteResp = PagedResponse<HotelModel>(
      page: 1,
      perPage: 10,
      total: 0,
      items: [],
    );
    final cached = {
      'ts': DateTime.now().millisecondsSinceEpoch,
      'page': 1,
      'perPage': 10,
      'total': 1,
      'items': [model.toJson()],
    };

    when(
      () => mockRemote.searchHotels(params),
    ).thenAnswer((_) async => remoteResp);
    when(() => mockCache.getHotels()).thenReturn(cached);

    final res = await repo.searchHotels(params);

    expect(res.items.isNotEmpty, true);
  });
}
