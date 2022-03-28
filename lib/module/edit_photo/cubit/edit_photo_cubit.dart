import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_pexels/data/constans/status_download.dart';
import 'package:photo_pexels/model/photo.dart';
import 'package:photo_pexels/module/edit_photo/widget/dragable_widget.dart';
import 'package:share_plus/share_plus.dart';

part 'edit_photo_state.dart';

class EditPhotoCubit extends Cubit<EditPhotoState> {
  EditPhotoCubit(this.photo) : super(EditPhotoState(photo: photo));

  Photo photo;

  void editLayer() {
    if (state.layerState == LayerState.idle) {
      emit(state.copyWith(layerState: LayerState.editing));
    } else {
      emit(state.copyWith(layerState: LayerState.idle));
    }
  }

  void updateLayerTrasparancy(double value) {
    emit(state.copyWith(layerOpacity: value));
  }

  void addWidget(DragableWidget widget) {
    emit(state.copyWith(
      widgets: List.of(state.widgets)..add(widget),
    ));
  }

  void changeWidgetState(WidgetState widgetState) {
    emit(state.copyWith(
      widgetState: widgetState,
    ));
  }

  void editWidget(int uniqueKey, DragableWidgetChild newChild) {
    var index = state.widgets.indexWhere((e) => e.uniqueKey == uniqueKey);
    if (index == -1) return;

    state.widgets[index].child = newChild;

    emit(state.copyWith(
      widgetState: WidgetState.edited,
      widgets: List.from(state.widgets),
    ));
  }

  void deleteWidget(int uniqueKey) {
    emit(state.copyWith(
      widgets: List.of(state.widgets)
        ..removeWhere((e) => e.uniqueKey == uniqueKey),
    ));
  }

  void changeDownloadState(StatusDownload status) {
    emit(state.copyWith(statusDownload: status));
  }

  void downloadImage(Uint8List image) async {
    final date = DateTime.now().millisecondsSinceEpoch;
    final directory = await _getDirectory();

    if (directory == null) return;

    try {
      final path = directory.path;
      final file = await File("$path/$date.jpeg").create();
      await file.writeAsBytes(image);
      emit(state.copyWith(statusDownload: StatusDownload.success));
    } catch (e) {
      emit(state.copyWith(statusDownload: StatusDownload.failed));
    } finally {
      emit(state.copyWith(statusDownload: StatusDownload.idle));
    }
  }

  void changeShareState(StatusDownload status) {
    emit(state.copyWith(statusShare: status));
  }

  void shareImage(Uint8List image) async {
    final date = DateTime.now().millisecondsSinceEpoch;
    final directory = await _getDirectory();

    if (directory == null) return;

    try {
      final path = directory.path;
      final file = await File("$path/$date.jpeg").create();
      await file.writeAsBytes(image);
      emit(state.copyWith(statusShare: StatusDownload.success));
      await Share.shareFiles([file.path]);
    } catch (e) {
      emit(state.copyWith(statusShare: StatusDownload.failed));
    } finally {
      emit(state.copyWith(statusShare: StatusDownload.idle));
    }
  }

  Future<Directory?> _getDirectory() async {
    Directory? directory;

    if (Platform.isAndroid) {
      var storage = await Permission.storage.isGranted;
      if (!storage) {
        var status = await Permission.storage.request();

        /// jika tidak di izinkan maka jangan di lanjutkan
        if (!status.isGranted) return null;
      }

      var externalStorage = await Permission.manageExternalStorage.isGranted;
      if (!externalStorage) {
        var status = await Permission.manageExternalStorage.request();

        /// jika tidak di izinkan maka jangan di lanjutkan
        if (!status.isGranted) return null;
      }

      directory = await getExternalStorageDirectory();

      String newPath = "";
      final paths = directory?.path.split("/");
      for (var i = 1; i < (paths?.length ?? 0); i++) {
        String path = paths?[i] ?? "";
        if (path == "Android") break;

        newPath += "/$path";
      }

      newPath += "/Pictures/Pexel";

      directory = Directory(newPath);
    } else {
      var photos = await Permission.photos.isGranted;
      if (!photos) {
        var status = await Permission.photos.request();

        /// jika tidak di izinkan maka jangan di lanjutkan
        if (!status.isGranted) return null;
      }

      directory = await getTemporaryDirectory();
    }

    if (!await directory.exists()) {
      directory.create(recursive: true);
    }

    return directory;
  }
}
