import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_pexels/module/edit_photo/cubit/edit_photo_cubit.dart';

class BasePhoto extends StatelessWidget {
  const BasePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photo = context.read<EditPhotoCubit>().state.photo;
    return Container(
      color: Colors.blueGrey[100],
      width: MediaQuery.of(context).size.width,
      child: Image(
        image: NetworkImage(photo.imageOriginal),
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Image(
            image: NetworkImage(photo.imageLarge),
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (_, __, ___) {
              return const Center(
                child: Icon(
                  Icons.broken_image_sharp,
                  color: Colors.blueGrey,
                ),
              );
            },
          );
        },
        errorBuilder: (_, __, ___) {
          return const Center(
            child: Icon(
              Icons.broken_image_sharp,
              color: Colors.blueGrey,
            ),
          );
        },
      ),
    );
  }
}
