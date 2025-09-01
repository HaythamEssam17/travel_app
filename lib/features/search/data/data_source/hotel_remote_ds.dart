import '../models/hotel_model.dart';
import '../models/paged_response.dart';
import '../models/search_params.dart';

abstract class HotelRemoteDataSource {
  Future<PagedResponse<HotelModel>> searchHotels(SearchParams params);
}
