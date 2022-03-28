import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_pexels/data/constans/status_download.dart';
import 'package:photo_pexels/model/photo.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';

part 'detail_photo_state.dart';

class DetailPhotoCubit extends Cubit<DetailPhotoState> {
  DetailPhotoCubit({
    required this.photo,
  }) : super(DetailPhotoState(photo: photo));

  final Photo photo;

  final dio = Dio();

  void shareImage() async {
    emit(state.copyWith(statusShare: StatusDownload.downloading));
    try {
      final response = await http.get(Uri.parse(photo.imageLarge));
      final bytes = response.bodyBytes;

      final temp = await getTemporaryDirectory();
      final path = "${temp.path}/shared_image.jpeg";
      File(path).writeAsBytesSync(bytes);

      emit(state.copyWith(statusShare: StatusDownload.success));
      await Share.shareFiles([path]);
    } catch (e) {
      emit(state.copyWith(statusShare: StatusDownload.failed));
    }
    emit(state.copyWith(statusShare: StatusDownload.idle));
  }

  void downloadImage() async {
    if (state.statusDownload == StatusDownload.downloading) return;

    final date = DateTime.now().millisecondsSinceEpoch;
    final directory = await _getDirectory();

    if (directory == null) return;

    try {
      final path = directory.path;
      final file = File("$path/$date.jpeg");
      emit(state.copyWith(statusDownload: StatusDownload.downloading));
      final response = await dio.download(
        photo.imageOriginal,
        file.path,
        deleteOnError: true,
        onReceiveProgress: (received, total) {
          emit(state.copyWith(
            progressDownload: (received / total * 100).toStringAsFixed(0),
          ));
        },
      );
      if (response.statusCode == 200) {
        emit(state.copyWith(
          statusDownload: StatusDownload.success,
          downloadedFilePath: file.path,
        ));
      }
    } catch (e) {
      emit(state.copyWith(statusDownload: StatusDownload.failed));
    } finally {
      emit(state.copyWith(statusDownload: StatusDownload.idle));
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
