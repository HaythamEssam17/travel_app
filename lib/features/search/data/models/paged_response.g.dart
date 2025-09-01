// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedResponse<T> _$PagedResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PagedResponse<T>(
  page: (json['page'] as num).toInt(),
  perPage: (json['perPage'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
);

Map<String, dynamic> _$PagedResponseToJson<T>(
  PagedResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'page': instance.page,
  'perPage': instance.perPage,
  'total': instance.total,
  'items': instance.items.map(toJsonT).toList(),
};
