import 'package:photo_pexels/model/video.dart';

class VideoResponse {
  final int page;
  final int perPage;
  final List<Video> videos;

  VideoResponse({
    required this.page,
    required this.perPage,
    required this.videos,
  });

  factory VideoResponse.fromJson(Map<String, dynamic> json) {
    return VideoResponse(
      page: json["page"],
      perPage: json["per_page"],
      videos: (json["videos"] as List).map((e) => Video.fromJson(e)).toList(),
    );
  }
}
