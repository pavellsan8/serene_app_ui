import 'package:flutter/material.dart';

class VideoDetailViewModel extends ChangeNotifier {
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
}
