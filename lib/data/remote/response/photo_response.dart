import 'package:photo_pexels/model/photo.dart';

class PhotoResponse {
  final int page;
  final int perPage;
  final List<Photo> photos;

  PhotoResponse({
    required this.page,
    required this.perPage,
    required this.photos,
  });

  factory PhotoResponse.fromJson(Map<String, dynamic> json) {
    return PhotoResponse(
      page: json["page"],
      perPage: json["per_page"],
      photos: (json["photos"] as List).map((e) => Photo.fromJson(e)).toList(),
    );
  }
}
