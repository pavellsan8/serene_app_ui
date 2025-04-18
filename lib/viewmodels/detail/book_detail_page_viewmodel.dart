import 'package:flutter/material.dart';

import '../../viewmodels/detail/toggle_favorites_viewmodel.dart';
import '../../services/favourite/template_favourite_service.dart';
import '../../services/favourite/book_favourite_service.dart';

class BookDetailViewModel extends ChangeNotifier with FavoriteToggleMixin {
  bool _isFavorite = false;
  bool isLoading = true;
  bool isDescriptionExpanded = false;

  final BookFavouriteService _bookFavouriteService = BookFavouriteService();

  @override
  bool get isFavorite => _isFavorite;

  @override
  void setFavorite(bool value) {
    _isFavorite = value;
  }

  @override
  BaseFavouriteService get favoriteService => _bookFavouriteService;

  void toggleDescription() {
    isDescriptionExpanded = !isDescriptionExpanded;
    notifyListeners();
  }

  String getHighQualityThumbnail(String? thumbnailUrl) {
    if (thumbnailUrl == null) return '';
    return thumbnailUrl.replaceFirst(RegExp(r'zoom=\d'), 'zoom=3');
  }
}