import 'package:flutter/material.dart';

class BookDetailViewModel extends ChangeNotifier {
  bool isFavorite = false;
  bool isDescriptionExpanded = false;

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

  void toggleDescription() {
    isDescriptionExpanded = !isDescriptionExpanded;
    notifyListeners();
  }

  String getHighQualityThumbnail(String? thumbnailUrl) {
    if (thumbnailUrl == null) return '';
    return thumbnailUrl.replaceFirst(RegExp(r'zoom=\d'), 'zoom=3');
  }
}
