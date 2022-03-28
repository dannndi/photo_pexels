import 'package:equatable/equatable.dart';
import 'package:photo_pexels/model/user.dart';

class Video extends Equatable {
  final int id;
  final int duration;
  final String image;
  final User user;
  final VideoFile? data;

  const Video({
    required this.id,
    required this.duration,
    required this.image,
    required this.user,
    required this.data,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json["id"],
      duration: json["duration"],
      image: json["image"],
      user: User.fromJson(json["user"]),
      data: (json["video_files"] as List).isNotEmpty
          ? VideoFile.fromJson((json["video_files"] as List)[0])
          : null,
    );
  }
  @override
  List<Object?> get props => [id, duration, image, user, data];
}

class VideoFile extends Equatable {
  final int id;
  final String quality;
  final String video;

  const VideoFile({
    required this.id,
    required this.quality,
    required this.video,
  });

  factory VideoFile.fromJson(Map<String, dynamic> json) {
    return VideoFile(
      id: json["id"],
      quality: json["quality"],
      video: json["link"],
    );
  }
  @override
  List<Object?> get props => [id, quality, video];
}
