part of 'photo_cubit.dart';

class PhotoState extends Equatable {
  const PhotoState({
    this.status = Status.initial,
    this.photos = const [],
    this.hasReachMax = false,
  });

  final Status status;
  final List<Photo> photos;
  final bool hasReachMax;

  PhotoState copyWith({
    Status? status,
    List<Photo>? photos,
    bool? hasReachMax,
  }) {
    return PhotoState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      hasReachMax: hasReachMax ?? this.hasReachMax,
    );
  }

  @override
  List<Object> get props => [status, photos, hasReachMax];
}
