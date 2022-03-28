import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_pexels/data/constans/status.dart';
import 'package:photo_pexels/data/repository/pexel_repository.dart';
import 'package:photo_pexels/model/collection.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit(this.repository) : super(const CollectionState());

  final PexelRepository repository;

  void getCollection() async {
    emit(state.copyWith(status: Status.loading));
    try {
      final result = await repository.fetchCollection();
      emit(state.copyWith(
        status: Status.sucess,
        collections: result,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
