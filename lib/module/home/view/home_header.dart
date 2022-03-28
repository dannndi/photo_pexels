import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_pexels/data/constans/status.dart';
import 'package:photo_pexels/model/collection.dart';
import 'package:photo_pexels/module/home/bloc/collection_cubit/collection_cubit.dart';
import 'package:photo_pexels/routes/page_name.dart';
import 'package:photo_pexels/theme/theme_application.dart';
import 'package:shimmer/shimmer.dart';

class HomeHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          if (overlapsContent)
            BoxShadow(
              color: Colors.grey[400]!,
              blurRadius: 0.5,
              spreadRadius: 1,
            ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 75,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello Pexels",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      "Explore Unlimited Photostock",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(PageName.search);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/ic_search.png"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(PageName.settings);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/ic_setting.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<CollectionCubit, CollectionState>(
            builder: (context, state) {
              if (state.status == Status.initial) {
                return _buildLoading();
              }
              if (state.status == Status.loading) {
                return _buildLoading();
              }
              if (state.status == Status.error) {
                return _buildError();
              }
              return _buildSuccess(state.collections);
            },
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 140;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Widget _buildError() {
    return const SizedBox();
  }

  Widget _buildLoading() {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(bottom: 16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              height: 60,
              width: 80,
              margin: EdgeInsets.fromLTRB(index == 0 ? 16 : 5, 5, 5, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSuccess(List<Collection> collections) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(bottom: 16),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: collections.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                PageName.search,
                arguments: collections[index].title,
              );
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(index == 0 ? 16 : 5, 5, 5, 0),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueGrey[100]!,
                    Colors.blueGrey[300]!,
                  ],
                  begin: const Alignment(-0.8, -1),
                  end: const Alignment(0.8, 1),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                collections[index].title,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: ThemeApplication.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
