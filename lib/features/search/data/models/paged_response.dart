import 'package:json_annotation/json_annotation.dart';

part 'paged_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PagedResponse<T> {
  final int page;
  final int perPage;
  final int total;
  final List<T> items;

  PagedResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.items,
  });

  factory PagedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PagedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PagedResponseToJson(this, toJsonT);
}
