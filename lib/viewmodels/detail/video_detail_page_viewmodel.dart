import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../services/favourite/video_favourite_service.dart';
import '../../services/favourite/template_favourite_service.dart';
import '../../viewmodels/detail/toggle_favorites_viewmodel.dart';

class VideoDetailViewModel extends ChangeNotifier with FavoriteToggleMixin {
  bool _isFavorite = false;
  bool isDescriptionExpanded = false;
  bool isFullScreen = false;

  final VideoFavouriteService _videoFavouriteService = VideoFavouriteService();

  @override
  bool get isFavorite => _isFavorite;

  @override
  void setFavorite(bool value) {
    _isFavorite = value;
  }

  @override
  BaseFavouriteService get favoriteService => _videoFavouriteService;

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
}
