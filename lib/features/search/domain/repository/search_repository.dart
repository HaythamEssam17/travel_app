import 'package:travel_app/features/search/domain/entites/hotel_entity.dart';

import '../../data/models/paged_response.dart';
import '../../data/models/search_params.dart';
import '../entites/flight_entity.dart';

abstract class ISearchRepository {
  Future<PagedResponse<FlightEntity>> searchFlights(SearchParams params);

  Future<PagedResponse<HotelEntity>> searchHotels(SearchParams params);
}
