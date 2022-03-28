import 'package:photo_pexels/model/collection.dart';
import 'package:photo_pexels/model/photo.dart';
import 'package:photo_pexels/model/video.dart';

abstract class PexelRepository {
  Future<List<Collection>> fetchCollection();

  Future<List<Video>> fetchPopularVideo();

  Future<List<Photo>> fetchPopularPhoto({String page = "1"});

  Future<List<Photo>> fetchPhotoByKeyword({
    String page = "1",
    String keyword = "",
  });
}
