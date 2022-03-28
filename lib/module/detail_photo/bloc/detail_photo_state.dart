part of 'detail_photo_cubit.dart';

class DetailPhotoState extends Equatable {
  const DetailPhotoState({
    required this.photo,
    this.statusDownload = StatusDownload.idle,
    this.progressDownload = "0",
    this.downloadedFilePath = "",
    this.statusShare = StatusDownload.idle,
  });

  final Photo photo;
  final StatusDownload statusDownload;
  final String progressDownload;
  final String downloadedFilePath;
  final StatusDownload statusShare;

  DetailPhotoState copyWith({
    StatusDownload? statusDownload,
    String? progressDownload,
    String? downloadedFilePath,
    StatusDownload? statusShare,
  }) {
    return DetailPhotoState(
      photo: photo,
      statusDownload: statusDownload ?? this.statusDownload,
      progressDownload: progressDownload ?? this.progressDownload,
      downloadedFilePath: downloadedFilePath ?? this.downloadedFilePath,
      statusShare: statusShare ?? this.statusShare,
    );
  }

  @override
  List<Object> get props => [
        photo,
        statusDownload,
        progressDownload,
        downloadedFilePath,
        statusShare,
      ];
}
