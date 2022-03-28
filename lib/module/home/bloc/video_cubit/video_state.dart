part of 'video_cubit.dart';

enum VideoStatus {
  initial,
  loading,
  success,
}

class VideoState extends Equatable {
  const VideoState({
    this.status = Status.initial,
    this.videos = const [],
  });

  final Status status;
  final List<Video> videos;

  VideoState copyWith({
    Status? status,
    List<Video>? videos,
  }) {
    return VideoState(
      status: status ?? this.status,
      videos: videos ?? this.videos,
    );
  }

  @override
  List<Object> get props => [status, videos];
}
