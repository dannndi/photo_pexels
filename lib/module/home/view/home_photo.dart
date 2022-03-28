import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_pexels/data/constans/status.dart';
import 'package:photo_pexels/model/photo.dart';
import 'package:photo_pexels/module/home/bloc/photo_cubit/photo_cubit.dart';
import 'package:photo_pexels/routes/page_name.dart';
import 'package:shimmer/shimmer.dart';

class HomePhoto extends StatelessWidget {
  const HomePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoCubit, PhotoState>(
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
        return _buildSuccess(state.photos);
      },
    );
  }

  Widget _buildError() {
    return const SizedBox();
  }

  Widget _buildLoading() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2 / 3,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.white,
            ),
          );
        },
        childCount: 6,
      ),
    );
  }

  Widget _buildSuccess(List<Photo> photos) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2 / 3,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
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
        childCount: photos.length,
      ),
    );
  }
}
