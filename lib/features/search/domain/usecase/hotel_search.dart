import 'package:injectable/injectable.dart';
import 'package:travel_app/features/search/domain/entites/hotel_entity.dart';
import 'package:travel_app/features/search/domain/repository/search_repository.dart';

import '../../data/models/paged_response.dart';
import '../../data/models/search_params.dart';

@Injectable()
class SearchHotels {
  final ISearchRepository repository;

  SearchHotels(this.repository);

  Future<PagedResponse<HotelEntity>> call(SearchParams params) async {
    return repository.searchHotels(params);
  }
}
