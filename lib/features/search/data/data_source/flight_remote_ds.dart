import '../models/flight_model.dart';
import '../models/paged_response.dart';
import '../models/search_params.dart';

abstract class FlightRemoteDataSource {
  Future<PagedResponse<FlightModel>> searchFlights(SearchParams params);
}
