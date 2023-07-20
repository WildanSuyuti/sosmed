abstract class BaseParam {
  Map<String, dynamic> toJson();
}

class ListParam extends BaseParam {
  final int? page;
  final int? limit;

  ListParam({this.page, this.limit});

  @override
  Map<String, dynamic> toJson() => {
        'page': page,
        'limit': limit,
      }..removeWhere((key, value) => value == null);
}
