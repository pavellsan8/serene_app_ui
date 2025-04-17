import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../models/favourite/favourite_model.dart';
import '../../services/favourite/video_favourite_service.dart';
import '../../utils/shared_preferences.dart';

class VideoDetailViewModel extends ChangeNotifier {
  bool isFavorite = false;
  bool isDescriptionExpanded = false;
  bool isFullScreen = false;

  final VideoFavouriteService videoFavouriteService = VideoFavouriteService();

  // YouTube controller reference
  YoutubePlayerController? _youtubeController;

  // Set the YouTube controller and add listener
  void setYoutubeController(YoutubePlayerController controller) {
    _youtubeController = controller;
    _youtubeController!.addListener(_onYoutubePlayerChange);
  }

  // Clean up controller listener
  void disposeYoutubeController() {
    if (_youtubeController != null) {
      _youtubeController!.removeListener(_onYoutubePlayerChange);
      _youtubeController = null;
    }
    // Ensure portrait orientation is restored when leaving the page
    setPortraitOrientation();
  }

  void _onYoutubePlayerChange() {
    // Check if fullscreen state has changed
    if (_youtubeController != null &&
        _youtubeController!.value.isFullScreen != isFullScreen) {
      isFullScreen = _youtubeController!.value.isFullScreen;

      // Set orientation based on fullscreen state
      if (isFullScreen) {
        setLandscapeOrientation();
      } else {
        setPortraitOrientation();
      }

      notifyListeners();
    }
  }

  void setPortraitOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void setLandscapeOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  // Handle back button press - returns true if should exit page, false otherwise
  bool handleBackButton() {
    // If in fullscreen, exit fullscreen but stay on the page
    if (isFullScreen && _youtubeController != null) {
      _youtubeController!.toggleFullScreenMode();
      return false;
    }
    // Otherwise, allow normal back navigation
    return true;
  }

  Future<void> toggleFavorite(BuildContext context, String itemId) async {
    final email = await ApplicationStorage.getEmail();

    if (email == null) {
      debugPrint('Email not found in SharedPreferences');
    }

    // Create the request object
    final request = ItemFavouriteRequest(
      email: email ?? '',
      itemId: itemId,
    );

    // Toggle favorite logic
    isFavorite = !isFavorite;
    notifyListeners();

    try {
      String apiMessage;
      if (isFavorite) {
        final response =
            await videoFavouriteService.addVideoFavourite(request: request);
        apiMessage = response.message;
      } else {
        final response =
            await videoFavouriteService.removeVideoFavourite(request: request);
        apiMessage = response.message;
      }

      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            apiMessage,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',
            ),
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      // Handle API errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to update favorite status. Please try again later.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',
            ),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
