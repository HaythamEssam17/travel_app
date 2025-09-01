import 'dart:math';

import 'package:injectable/injectable.dart';

import '../models/hotel_model.dart';
import '../models/paged_response.dart';
import '../models/search_params.dart';
import 'hotel_remote_ds.dart';

@Injectable(as: HotelRemoteDataSource)
class HotelRemoteDataSourceMock implements HotelRemoteDataSource {
  final Random _rnd = Random(99);
  final List<String> hotels = [
    'Sunrise',
    'Royal Inn',
    'Grand Plaza',
    'Sea Breeze',
    'City Lodge',
  ];
  final List<String> cities = ['Cairo', 'Dubai', 'Istanbul', 'Paris', 'London'];

  @override
  Future<PagedResponse<HotelModel>> searchHotels(SearchParams params) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final total = 120;
    final start = (params.page - 1) * params.perPage;
    final end = min(start + params.perPage, total);
    final List<HotelModel> items = [];
    for (var i = start; i < end; i++) {
      final city = params.query ?? cities[i % cities.length];
      final rating = 3.0 + (i % 3).toDouble(); // 3,4,5
      double price = 40 + (i % 80);
      final h = HotelModel(
        id: 'H${i + 1}',
        name: '${hotels[i % hotels.length]} ${i + 1}',
        rating: rating,
        pricePerNight: price,
        city: city,
        imageUrl: 'https://picsum.photos/seed/hotel$i/400/300',
      );
      items.add(h);
    }
    // apply client-side rating & price filters
    final filtered = items.where((h) {
      if (params.minRating != null && h.rating! < params.minRating!) {
        return false;
      }
      if (params.minPrice != null && h.pricePerNight! < params.minPrice!) {
        return false;
      }
      if (params.maxPrice != null &&
          h.pricePerNight! > (params.maxPrice ?? double.infinity)) {
        return false;
      }
      return true;
    }).toList();
    return PagedResponse<HotelModel>(
      page: params.page,
      perPage: params.perPage,
      total: total,
      items: filtered,
    );
  }
}
