import 'package:flutter/material.dart';

import '../../models/main/video_page_model.dart';
import '../../services/favourite/video_favourite_service.dart';
import '../../utils/shared_preferences.dart';

class VideoFavoritesViewModel extends ChangeNotifier {
  final VideoFavouriteService videoFavouriteService = VideoFavouriteService();
  bool isLoading = true;
  List<Video> favoriteVideos = [];

  Future<void> fetchFavoriteVideos() async {
    try {
      final email = await ApplicationStorage.getEmail();
      debugPrint("Fetching favorite videos for email: $email");

      final response = await videoFavouriteService.getData(email: email);
      debugPrint("Videos found: ${response.data.length}");

      favoriteVideos = response.data;
    } catch (e) {
      debugPrint("Error fetching favorite videos: $e");
      favoriteVideos = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
