import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_pexels/data/constans/status.dart';
import 'package:photo_pexels/data/repository/pexel_repository.dart';
import 'package:photo_pexels/model/video.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit(this.repository) : super(const VideoState());
  final PexelRepository repository;

  void getPopularVideos() async {
    emit(state.copyWith(status: Status.loading));
    try {
      final result = await repository.fetchPopularVideo();
      emit(state.copyWith(
        status: Status.sucess,
        videos: result,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
