import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_pexels/data/constans/status.dart';
import 'package:photo_pexels/data/repository/pexel_repository.dart';
import 'package:photo_pexels/model/photo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.repository) : super(const SearchState());

  final PexelRepository repository;

  int page = 1;

  void onChangeKeyword(String value) {
    /// jika user click delete setelah tidak ada huruf tersisa di textfield
    if (value.isEmpty && state.keyword.isEmpty) return;

    /// jika user pertama kali mengetik huruf
    if (value.isNotEmpty && state.keyword.isEmpty) {
      emit(state.copyWith(keyword: value));
      return;
    }

    /// jika user mendelete semua keyword
    if (value.isEmpty && state.keyword.isNotEmpty) {
      emit(state.copyWith(keyword: value));
      return;
    }
  }

  void clearKeyword() {
    emit(state.copyWith(keyword: ""));
  }

  void onSearch(String value) {
    if (value.isEmpty) return;

    page = 1;
    emit(state.copyWith(
      status: Status.loading,
      searchResult: [],
      keyword: value,
      hasReachMax: false,
    ));

    _getPhotoByKeyword(page);
  }

  void refreshPage() {
    emit(state.copyWith(
      status: Status.loading,
      searchResult: [],
      hasReachMax: false,
    ));
    page = 1;
    _getPhotoByKeyword(page);
  }

  void loadNextPage() {
    if (state.hasReachMax) return;
    page++;
    _getPhotoByKeyword(page);
  }

  void _getPhotoByKeyword(int page) async {
    try {
      var photos = await repository.fetchPhotoByKeyword(
        keyword: state.keyword,
        page: "$page",
      );

      if (photos.isEmpty) {
        emit(state.copyWith(
          status: Status.sucess,
          hasReachMax: true,
        ));

        return;
      }

      emit(state.copyWith(
        status: Status.sucess,
        searchResult: List.of(state.searchResult)..addAll(photos),
        hasReachMax: false,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
