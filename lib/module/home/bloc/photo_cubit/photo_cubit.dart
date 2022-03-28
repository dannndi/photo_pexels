import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_pexels/data/constans/status.dart';
import 'package:photo_pexels/data/repository/pexel_repository.dart';
import 'package:photo_pexels/model/photo.dart';

part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit(this.repository) : super(const PhotoState());

  final PexelRepository repository;
  int page = 1;

  void resetPage() {
    emit(state.copyWith(
      status: Status.initial,
      photos: [],
      hasReachMax: false,
    ));
    page = 1;
  }

  void getPopularPhoto() async {
    try {
      final photos = await repository.fetchPopularPhoto(page: "$page");
      if (photos.isEmpty) {
        return emit(state.copyWith(
          status: Status.sucess,
          hasReachMax: true,
        ));
      }

      emit(state.copyWith(
        status: Status.sucess,
        photos: List.of(state.photos)..addAll(photos),
        hasReachMax: false,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  void loadNextPage() {
    if (state.hasReachMax) return;

    page++;
    getPopularPhoto();
  }
}
