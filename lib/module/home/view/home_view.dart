import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_pexels/data/constans/status.dart';
import 'package:photo_pexels/module/home/bloc/collection_cubit/collection_cubit.dart';
import 'package:photo_pexels/module/home/bloc/photo_cubit/photo_cubit.dart';
import 'package:photo_pexels/module/home/bloc/video_cubit/video_cubit.dart';
import 'package:photo_pexels/module/home/view/home_photo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_header.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final _controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<PhotoCubit, PhotoState>(
          listener: (context, state) {
            if (state.status == Status.sucess) {
              if (_controller.isRefresh) {
                _controller.refreshCompleted(resetFooterState: true);
              }

              if (_controller.isLoading) {
                _controller.loadComplete();
              }
            }
          },
          child: SmartRefresher(
            controller: _controller,
            enablePullUp: true,
            enablePullDown: true,
            onRefresh: () {
              context.read<CollectionCubit>().getCollection();
              context.read<VideoCubit>().getPopularVideos();
              context.read<PhotoCubit>().resetPage();
              context.read<PhotoCubit>().getPopularPhoto();
            },
            onLoading: () {
              context.read<PhotoCubit>().loadNextPage();
            },
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  floating: true,
                  pinned: false,
                  delegate: HomeHeader(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      "Popular Photo",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: HomePhoto(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
