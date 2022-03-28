import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_pexels/module/edit_photo/cubit/edit_photo_cubit.dart';

Widget dialogDeleteTextConfirmation(BuildContext context, int uniqueKey) {
  return AlertDialog(
    backgroundColor: Theme.of(context).backgroundColor,
    content: Text(
      "Are you sure want to delete this widget ?",
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          "Cancel",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      ElevatedButton(
        onPressed: () {
          context.read<EditPhotoCubit>().deleteWidget(uniqueKey);
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
        ),
        child: Text(
          "Delete",
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: Colors.white),
        ),
      )
    ],
  );
}
