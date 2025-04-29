import '../../models/main/video_page_model.dart';
import '../../../services/main/video_page_service.dart';
import '../../viewmodels/main/generic_page_viewmodel.dart';

class VideoPageViewModel extends GenericPageViewModel<Video> {
  final VideoService videoService = VideoService();

  // Override fetchData to return Musics
  @override
  Future<List<Video>> fetchData() async {
    final VideoResponse response = await videoService.getVideoData();
    return response.data;
  }
}
