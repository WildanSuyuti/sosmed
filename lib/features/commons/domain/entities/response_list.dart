class ResponseList<Entity> {
  final int page;
  final int limit;
  final int total;
  final List<Entity> data;

  ResponseList({
    required this.page,
    required this.limit,
    required this.total,
    required this.data,
  });

  ResponseList<Entity> copyWith({
    int? page,
    int? limit,
    int? total,
    List<Entity>? data,
  }) {
    return ResponseList(
      data: data ?? this.data,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      total: total ?? this.total,
    );
  }
}
