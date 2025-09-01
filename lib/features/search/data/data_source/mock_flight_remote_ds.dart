import 'dart:math';

import 'package:injectable/injectable.dart';

import '../models/flight_model.dart';
import '../models/paged_response.dart';
import '../models/search_params.dart';
import 'flight_remote_ds.dart';

@Injectable(as: FlightRemoteDataSource)
class MockFlightRemoteDataSource implements FlightRemoteDataSource {
  final Random _rnd = Random(42);
  final List<String> airlines = [
    'EgyptAir',
    'Emirates',
    'Qatar',
    'Lufthansa',
    'Turkish',
  ];

  @override
  Future<PagedResponse<FlightModel>> searchFlights(SearchParams params) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final total = 200;
    final start = (params.page - 1) * params.perPage;
    final end = min(start + params.perPage, total);
    final items = <FlightModel>[];
    for (var i = start; i < end; i++) {
      final a = params.airlines != null && params.airlines!.isNotEmpty
          ? params.airlines![_rnd.nextInt(params.airlines!.length)]
          : airlines[i % airlines.length];
      double price = 100 + (i % 50) * 4.5;
      if (params.minPrice != null && price < params.minPrice!) {
        price = params.minPrice!;
      }
      if (params.maxPrice != null &&
          price > (params.maxPrice ?? double.infinity)) {
        price = params.maxPrice ?? price;
      }
      final depart = DateTime.now().add(Duration(hours: i % 48));
      final arrive = depart.add(Duration(minutes: 60 + (i % 300)));
      items.add(
        FlightModel(
          id: 'F${i + 1}',
          airline: a,
          price: price,
          departAt: depart.toIso8601String(),
          arriveAt: arrive.toIso8601String(),
          stops: i % 3,
        ),
      );
    }
    return PagedResponse<FlightModel>(
      page: params.page,
      perPage: params.perPage,
      total: total,
      items: items,
    );
  }
}
