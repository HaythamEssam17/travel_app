import 'package:injectable/injectable.dart';

import '../../data/models/paged_response.dart';
import '../../data/models/search_params.dart';
import '../entites/flight_entity.dart';
import '../repository/search_repository.dart';

@Injectable()
class SearchFlights {
  final ISearchRepository repository;

  SearchFlights(this.repository);

  Future<PagedResponse<FlightEntity>> call(SearchParams params) async {
    return repository.searchFlights(params);
  }
}
