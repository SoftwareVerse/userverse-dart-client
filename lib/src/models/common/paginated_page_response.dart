import 'dart:convert';
import 'package:userverse_dart_client/src/models/common/pagination_meta.dart';

class PaginatedPageResponse<T> {
  PaginatedPageResponse({
    required this.records,
    required this.pagination,
  });

  factory PaginatedPageResponse.fromJson(
    String source,
    T Function(Map<String, dynamic>) fromJsonT,
  ) =>
      PaginatedPageResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
        fromJsonT,
      );

  factory PaginatedPageResponse.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedPageResponse<T>(
      records: List<T>.from(
        (map['records'] as List<dynamic>).map<T>(
          (x) => fromJsonT(x as Map<String, dynamic>),
        ),
      ),
      pagination:
          PaginationMeta.fromMap(map['pagination'] as Map<String, dynamic>),
    );
  }
  final List<T> records;
  final PaginationMeta pagination;

  PaginatedPageResponse<T> copyWith({
    List<T>? records,
    PaginationMeta? pagination,
  }) {
    return PaginatedPageResponse<T>(
      records: records ?? this.records,
      pagination: pagination ?? this.pagination,
    );
  }

  @override
  String toString() =>
      'PaginatedPageResponse(records: $records, pagination: $pagination)';

  @override
  bool operator ==(covariant PaginatedPageResponse<T> other) {
    if (identical(this, other)) return true;

    return other.records == records && other.pagination == pagination;
  }

  @override
  int get hashCode => records.hashCode ^ pagination.hashCode;
}
