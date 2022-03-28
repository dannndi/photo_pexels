import 'package:photo_pexels/data/remote/response/collection_response.dart';
import 'package:photo_pexels/data/remote/response/photo_response.dart';
import 'package:photo_pexels/data/remote/response/video_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'pexel_services.g.dart';

@RestApi(baseUrl: "https://api.pexels.com/")
abstract class PexelServices {
  factory PexelServices(Dio diom, {String baseUrl}) = _PexelServices;

  static PexelServices create() {
    final dio = Dio();
    dio.options.headers["Authorization"] =
        "563492ad6f917000010000017470b715d836489796ea7954f21118b8";
    return PexelServices(dio);
  }

  @GET("v1/collections/featured")
  Future<CollectionResponse> fetchCollection({
    @Query("page") String page = "1",
    @Query("per_page") String perPage = "24",
  });

  @GET("videos/popular")
  Future<VideoResponse> fetchPopularVideo({
    @Query("page") String page = "1",
    @Query("per_page") String perPage = "24",
  });

  @GET("v1/curated")
  Future<PhotoResponse> fetchPopularPhoto({
    @Query("page") String page = "1",
    @Query("per_page") String perPage = "24",
  });

  @GET("v1/search")
  Future<PhotoResponse> fetchPhotoByQuery({
    @Query("query") String keyword = "",
    @Query("page") String page = "1",
    @Query("per_page") String perPage = "24",
  });
}
