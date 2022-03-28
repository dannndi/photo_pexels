import 'package:photo_pexels/data/remote/pexel_services.dart';
import 'package:photo_pexels/data/repository/pexel_repository.dart';
import 'package:photo_pexels/model/photo.dart';
import 'package:photo_pexels/model/collection.dart';
import 'package:photo_pexels/model/video.dart';

class PexelRepositoryImpl implements PexelRepository {
  final PexelServices client;

  PexelRepositoryImpl(this.client);

  @override
  Future<List<Collection>> fetchCollection() async {
    try {
      final result = await client.fetchCollection();
      return result.collections;
    } catch (e) {
      throw Exception("Error, coba beberapa saat lagi!");
    }
  }

  @override
  Future<List<Video>> fetchPopularVideo() async {
    try {
      final result = await client.fetchPopularVideo();
      return result.videos;
    } catch (e) {
      throw Exception("Error, coba beberapa saat lagi!");
    }
  }

  @override
  Future<List<Photo>> fetchPopularPhoto({String page = "1"}) async {
    try {
      final result = await client.fetchPopularPhoto(
        page: page,
      );
      return result.photos;
    } catch (e) {
      throw Exception("Error, coba beberapa saat lagi!");
    }
  }

  @override
  Future<List<Photo>> fetchPhotoByKeyword({
    String page = "1",
    String keyword = "",
  }) async {
    try {
      final result = await client.fetchPhotoByQuery(
        keyword: keyword,
        page: page,
      );
      return result.photos;
    } catch (e) {
      throw Exception("Error, coba beberapa saat lagi!");
    }
  }
}
