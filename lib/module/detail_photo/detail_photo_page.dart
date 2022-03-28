import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_pexels/model/photo.dart';
import 'package:photo_pexels/module/detail_photo/bloc/detail_photo_cubit.dart';
import 'package:photo_pexels/module/detail_photo/view/detail_photo_view.dart';

class DetailPhotoPage extends StatelessWidget {
  const DetailPhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photo = ModalRoute.of(context)?.settings.arguments as Photo;
    return BlocProvider(
      create: (context) => DetailPhotoCubit(
        photo: photo,
      ),
      child: const DetailPhotoView(),
    );
  }
}
