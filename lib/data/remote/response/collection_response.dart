import 'package:photo_pexels/model/collection.dart';

class CollectionResponse {
  final int page;
  final int perPage;
  final List<Collection> collections;

  CollectionResponse({
    required this.page,
    required this.perPage,
    required this.collections,
  });

  factory CollectionResponse.fromJson(Map<String, dynamic> json) {
    return CollectionResponse(
      page: json["page"],
      perPage: json["per_page"],
      collections: (json["collections"] as List)
          .map((e) => Collection.fromJson(e))
          .toList(),
    );
  }
}
