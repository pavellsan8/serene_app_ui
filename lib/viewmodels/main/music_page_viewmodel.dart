import '../../models/main/music_page_model.dart';
import '../../../services/main/music_page_service.dart';
import '../../viewmodels/main/generic_page_viewmodel.dart';

class MusicPageViewModel extends GenericPageViewModel<Music> {
  final MusicService musicService = MusicService();

  // Override fetchData to return Musics
  @override
  Future<List<Music>> fetchData() async {
    final MusicResponse response = await musicService.getMusicData();
    return response.data;
  }
}
