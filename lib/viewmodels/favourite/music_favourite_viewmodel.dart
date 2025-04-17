import 'package:flutter/material.dart';

import '../../models/main/music_page_model.dart';
import '../../services/favourite/music_favourite_service.dart';
import '../../utils/shared_preferences.dart';

class MusicFavoritesViewModel extends ChangeNotifier {
  final MusicFavouriteService _musicFavouriteService = MusicFavouriteService();
  bool isLoading = true;
  List<Music> favoriteMusics = [];

  Future<void> fetchFavoriteMusics() async {
    try {
      final email = await ApplicationStorage.getEmail();
      debugPrint("Fetching favorite Musics for email: $email");

      final response = await _musicFavouriteService.getMusicData(email: email);
      debugPrint("Musics found: ${response.data.length}");

      favoriteMusics = response.data;
    } catch (e) {
      debugPrint("Error fetching favorite musics: $e");
      favoriteMusics = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
