// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../models/favourite/favourite_model.dart';
import '../../services/favourite/book_favourite_service.dart';
import '../../utils/shared_preferences.dart';

class BookDetailViewModel extends ChangeNotifier {
  bool isFavorite = false;
  bool isLoading = true;
  bool isDescriptionExpanded = false;

  final BookFavouriteService bookFavouriteService = BookFavouriteService();

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
            await bookFavouriteService.addBookFavourite(request: request);
        apiMessage = response.message;
      } else {
        final response =
            await bookFavouriteService.removeBookFavourite(request: request);
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

  void toggleDescription() {
    isDescriptionExpanded = !isDescriptionExpanded;
    notifyListeners();
  }

  String getHighQualityThumbnail(String? thumbnailUrl) {
    if (thumbnailUrl == null) return '';
    return thumbnailUrl.replaceFirst(RegExp(r'zoom=\d'), 'zoom=3');
  }
}
