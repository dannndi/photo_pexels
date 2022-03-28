part of 'collection_cubit.dart';

class CollectionState extends Equatable {
  const CollectionState({
    this.status = Status.initial,
    this.collections = const [],
  });

  final Status status;
  final List<Collection> collections;

  CollectionState copyWith({
    Status? status,
    List<Collection>? collections,
  }) {
    return CollectionState(
      status: status ?? this.status,
      collections: collections ?? this.collections,
    );
  }

  @override
  List<Object> get props => [status, collections];
}
