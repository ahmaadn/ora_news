class Pagination {
  final int count;
  final List<dynamic> items;
  final int currPage;
  final int totalPage;
  final String nextPage;
  final String previousPage;

  Pagination({
    required this.count,
    required this.items,
    required this.currPage,
    required this.totalPage,
    required this.nextPage,
    required this.previousPage,
  });

  Pagination copyWith({
    int? count,
    List<dynamic>? items,
    int? currPage,
    int? totalPage,
    String? nextPage,
    String? previousPage,
  }) => Pagination(
    count: count ?? this.count,
    items: items ?? this.items,
    currPage: currPage ?? this.currPage,
    totalPage: totalPage ?? this.totalPage,
    nextPage: nextPage ?? this.nextPage,
    previousPage: previousPage ?? this.previousPage,
  );

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    count: json["count"],
    items: json['items'],
    currPage: json["curr_page"],
    totalPage: json["total_page"],
    nextPage: json["next_page"],
    previousPage: json["previous_page"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "curr_page": currPage,
    "total_page": totalPage,
    "next_page": nextPage,
    "previous_page": previousPage,
  };
}
