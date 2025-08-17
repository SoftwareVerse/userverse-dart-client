import 'dart:convert';

class PaginationMeta {
  PaginationMeta({
    required this.totalRecords,
    required this.limit,
    required this.page,
    required this.totalPages,
  });

  factory PaginationMeta.fromJson(String source) =>
      PaginationMeta.fromMap(json.decode(source) as Map<String, dynamic>);

  factory PaginationMeta.fromMap(Map<String, dynamic> map) {
    return PaginationMeta(
      totalRecords: map['total_records'] as int,
      limit: map['limit'] as int,
      page: map['page'] as int,
      totalPages: map['total_pages'] as int,
    );
  }
  final int totalRecords;
  final int limit;
  final int page;
  final int totalPages;

  PaginationMeta copyWith({
    int? totalRecords,
    int? limit,
    int? page,
    int? totalPages,
  }) {
    return PaginationMeta(
      totalRecords: totalRecords ?? this.totalRecords,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_records': totalRecords,
      'limit': limit,
      'page': page,
      'total_pages': totalPages,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'PaginationMeta(totalRecords: $totalRecords, limit: $limit, page: $page, totalPages: $totalPages)';
  }

  @override
  bool operator ==(covariant PaginationMeta other) {
    if (identical(this, other)) return true;

    return other.totalRecords == totalRecords &&
        other.limit == limit &&
        other.page == page &&
        other.totalPages == totalPages;
  }

  @override
  int get hashCode {
    return totalRecords.hashCode ^
        limit.hashCode ^
        page.hashCode ^
        totalPages.hashCode;
  }
}
