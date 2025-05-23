import '../../models/main/video_page_model.dart';
import '../../services/favourite/template_favourite_service.dart';

class VideoFavouriteService extends BaseFavouriteService<VideoResponse> {
  VideoFavouriteService() : super("video", "video_id");

  @override
  VideoResponse parseResponse(Map<String, dynamic> json) {
    return VideoResponse.fromJson(json);
  }
}
