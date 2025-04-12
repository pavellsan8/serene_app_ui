import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailViewModel extends ChangeNotifier {
  bool isFavorite = false;
  bool isDescriptionExpanded = false;
  bool isFullScreen = false;

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

  void toggleFavorite(BuildContext context) {
    isFavorite = !isFavorite;
    notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'Added to favorites!' : 'Removed from favorites!',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
