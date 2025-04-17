import '../../models/main/music_page_model.dart';
import '../../services/favourite/template_favourite_service.dart';

class MusicFavouriteService extends BaseFavouriteService<MusicResponse> {
  MusicFavouriteService() : super("music", "music_id");

  @override
  MusicResponse parseResponse(Map<String, dynamic> json) {
    return MusicResponse.fromJson(json);
  }
}
