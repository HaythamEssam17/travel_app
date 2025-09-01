class SearchParams {
  final String? query;
  final int page;
  final int perPage;
  final double? minPrice;
  final double? maxPrice;
  final List<String>? airlines;
  final double? minRating;

  SearchParams({
    this.query,
    this.page = 1,
    this.perPage = 10,
    this.minPrice,
    this.maxPrice,
    this.airlines,
    this.minRating,
  });

  SearchParams copyWith({
    String? query,
    int? page,
    int? perPage,
    double? minPrice,
    double? maxPrice,
    List<String>? airlines,
    double? minRating,
  }) {
    return SearchParams(
      query: query ?? this.query,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      airlines: airlines ?? this.airlines,
      minRating: minRating ?? this.minRating,
    );
  }
}
