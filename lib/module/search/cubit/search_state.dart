part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState({
    this.status = Status.initial,
    this.keyword = "",
    this.searchResult = const [],
    this.hasReachMax = false,
  });

  final Status status;
  final String keyword;
  final List<Photo> searchResult;
  final bool hasReachMax;

  SearchState copyWith({
    Status? status,
    String? keyword,
    List<Photo>? searchResult,
    bool? hasReachMax,
  }) {
    return SearchState(
      status: status ?? this.status,
      keyword: keyword ?? this.keyword,
      searchResult: searchResult ?? this.searchResult,
      hasReachMax: hasReachMax ?? this.hasReachMax,
    );
  }

  @override
  List<Object> get props => [status, keyword, searchResult, hasReachMax];
}
