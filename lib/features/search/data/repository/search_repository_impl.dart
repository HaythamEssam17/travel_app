import 'package:injectable/injectable.dart';
import 'package:travel_app/core/services/hive_service.dart';
import 'package:travel_app/features/search/domain/entites/flight_entity.dart';
import 'package:travel_app/features/search/domain/entites/hotel_entity.dart';
import 'package:travel_app/features/search/domain/repository/search_repository.dart';

import '../data_source/flight_remote_ds.dart';
import '../data_source/hotel_remote_ds.dart';
import '../models/flight_model.dart';
import '../models/hotel_model.dart';
import '../models/paged_response.dart';
import '../models/search_params.dart';

@Injectable(as: ISearchRepository)
class SearchRepositoryImpl implements ISearchRepository {
  final FlightRemoteDataSource flightRemote;
  final HotelRemoteDataSource hotelRemote;
  final HiveServiceProvider cache = HiveServiceProvider.i;
  static const int ttlSeconds = 15 * 60;

  SearchRepositoryImpl({required this.flightRemote, required this.hotelRemote});

  @override
  Future<PagedResponse<FlightEntity>> searchFlights(SearchParams params) async {
    final Map<String, dynamic>? cached = cache.getFlights();
    if (cached != null) {
      final ts = cached['ts'] as int;
      final fetched = DateTime.fromMillisecondsSinceEpoch(ts);
      if (DateTime.now().difference(fetched).inSeconds < ttlSeconds) {
        final itemsJson = List<Map<String, dynamic>>.from(cached['items']);
        final items = itemsJson
            .map((j) => FlightModel.fromJson(j).toEntity())
            .toList();
        return PagedResponse<FlightEntity>(
          page: cached['page'],
          perPage: cached['perPage'],
          total: cached['total'],
          items: items,
        );
      }
    }

    final res = await flightRemote.searchFlights(params);
    await cache.saveFlights({
      'ts': DateTime.now().millisecondsSinceEpoch,
      'page': res.page,
      'perPage': res.perPage,
      'total': res.total,
      'items': res.items.map((m) => m.toJson()).toList(),
    });
    final entities = res.items.map((m) => m.toEntity()).toList();
    return PagedResponse<FlightEntity>(
      page: res.page,
      perPage: res.perPage,
      total: res.total,
      items: entities,
    );
  }

  @override
  Future<PagedResponse<HotelEntity>> searchHotels(SearchParams params) async {
    // final key = _key('hotels', params);
    final cached = cache.getHotels();
    if (cached != null) {
      final ts = cached['ts'] as int;
      final fetched = DateTime.fromMillisecondsSinceEpoch(ts);
      if (DateTime.now().difference(fetched).inSeconds < ttlSeconds) {
        final itemsJson = List<Map<String, dynamic>>.from(cached['items']);
        final items = itemsJson
            .map((j) => HotelModel.fromJson(j).toEntity())
            .toList();
        return PagedResponse<HotelEntity>(
          page: cached['page'],
          perPage: cached['perPage'],
          total: cached['total'],
          items: items,
        );
      }
    }

    final res = await hotelRemote.searchHotels(params);
    await cache.saveHotels({
      'ts': DateTime.now().millisecondsSinceEpoch,
      'page': res.page,
      'perPage': res.perPage,
      'total': res.total,
      'items': res.items.map((m) => m.toJson()).toList(),
    });
    final entities = res.items.map((m) => m.toEntity()).toList();
    return PagedResponse<HotelEntity>(
      page: res.page,
      perPage: res.perPage,
      total: res.total,
      items: entities,
    );
  }
}
