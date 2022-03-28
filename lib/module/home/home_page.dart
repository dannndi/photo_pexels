import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_pexels/data/repository/pexel_repository.dart';
import 'package:photo_pexels/dependency_injection.dart';
import 'package:photo_pexels/module/home/bloc/collection_cubit/collection_cubit.dart';
import 'package:photo_pexels/module/home/bloc/photo_cubit/photo_cubit.dart';
import 'package:photo_pexels/module/home/bloc/video_cubit/video_cubit.dart';
import 'package:photo_pexels/module/home/view/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CollectionCubit(
            inject.get<PexelRepository>(),
          )..getCollection(),
        ),
        BlocProvider(
          create: (context) => PhotoCubit(
            inject.get<PexelRepository>(),
          )..getPopularPhoto(),
        ),
        BlocProvider(
          create: (context) => VideoCubit(
            inject.get<PexelRepository>(),
          )..getPopularVideos(),
        ),
      ],
      child: HomeView(),
    );
  }
}
