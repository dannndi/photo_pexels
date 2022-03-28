import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_pexels/data/constans/status.dart';
import 'package:photo_pexels/model/photo.dart';
import 'package:photo_pexels/module/search/cubit/search_cubit.dart';
import 'package:photo_pexels/routes/page_name.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _controller = RefreshController();
  final _keywordController = TextEditingController();
  String? initialKeyword;

  @override
  void didChangeDependencies() {
    initialKeyword = ModalRoute.of(context)?.settings.arguments as String?;

    if (initialKeyword == null) return;
    if (initialKeyword?.isNotEmpty ?? false) {
      _keywordController.text = initialKeyword ?? "";
      context.read<SearchCubit>().onSearch(initialKeyword ?? "");
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          iconSize: 20,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).textTheme.headline1?.color,
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        title: TextField(
          controller: _keywordController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "e.g : Winter",
            hintStyle: Theme.of(context).textTheme.bodySmall,
          ),
          style: Theme.of(context).textTheme.bodyLarge,
          autofocus: initialKeyword != null ? false : true,
          textInputAction: TextInputAction.search,
          onChanged: context.read<SearchCubit>().onChangeKeyword,
          onSubmitted: context.read<SearchCubit>().onSearch,
        ),
        actions: [
          BlocBuilder<SearchCubit, SearchState>(
            builder: (_, state) {
              if (state.keyword.isNotEmpty) {
                return IconButton(
                  onPressed: () {
                    _keywordController.clear();
                    context.read<SearchCubit>().clearKeyword();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).textTheme.headline1?.color,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
        elevation: 1,
      ),
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state.status == Status.sucess) {
            _controller.refreshCompleted(resetFooterState: true);
            _controller.loadComplete();
          }

          if (state.status == Status.error) {
            _controller.loadFailed();
          }

          if (state.hasReachMax) {
            _controller.loadNoData();
          }
        },
        builder: (context, state) {
          if (state.status == Status.initial) return const SizedBox();
          if (state.status == Status.loading) return _buildLoading(context);
          return _buildSuccess(context, state.searchResult);
        },
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Text(
        "Not found",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<Photo> photos) {
    if (photos.isEmpty) return _buildEmpty(context);
    return SmartRefresher(
      controller: _controller,
      enablePullUp: true,
      enablePullDown: true,
      onRefresh: context.read<SearchCubit>().refreshPage,
      onLoading: context.read<SearchCubit>().loadNextPage,
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2 / 3,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                PageName.detailPhoto,
                arguments: photos[index],
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image(
                  image: NetworkImage(photos[index].imageLarge),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return const Center(
                      child: Icon(
                        Icons.broken_image_sharp,
                        color: Colors.blueGrey,
                      ),
                    );
                  },
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 16,
                  child: Text(
                    photos[index].photographer,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
