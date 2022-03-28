import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_pexels/module/edit_photo/cubit/edit_photo_cubit.dart';
import 'package:photo_pexels/module/edit_photo/view/base_photo.dart';

class EditPhotoView extends StatelessWidget {
  const EditPhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPhotoCubit, EditPhotoState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: const [
            BasePhoto(),
            EditLayer(),
          ],
        );
      },
    );
  }
}

class EditLayer extends StatelessWidget {
  const EditLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPhotoCubit, EditPhotoState>(
      buildWhen: (p, c) {
        final changeOnWidgets = p.widgets.length != c.widgets.length;
        final editedWidget = p.widgetState != c.widgetState;
        final editedLayer = p.layerOpacity != c.layerOpacity;
        return changeOnWidgets || editedWidget || editedLayer;
      },
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(state.layerOpacity),
              ),
            ),

            /// widgets
            for (var i = 0; i < state.widgets.length; i++)
              Align(
                key: UniqueKey(),
                alignment: Alignment.center,
                child: state.widgets[i],
              ),
          ],
        );
      },
    );
  }
}
