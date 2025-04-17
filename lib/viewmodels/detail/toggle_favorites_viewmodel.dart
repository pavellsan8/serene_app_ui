// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../models/favourite/favourite_model.dart';
import '../../services/favourite/template_favourite_service.dart';
import '../../utils/shared_preferences.dart';

mixin FavoriteToggleMixin {
  BaseFavouriteService get favoriteService;
  
  /// Whether the current item is favorited.
  bool get isFavorite;
  
  /// Set the favorite status.
  void setFavorite(bool value);
  void notifyListeners();

  /// Toggles the favorite status of an item.
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
    setFavorite(!isFavorite);
    notifyListeners();

    try {
      String apiMessage;
      if (isFavorite) {
        final response = await favoriteService.addFavourite(request: request);
        apiMessage = response.message;
      } else {
        final response = await favoriteService.removeFavourite(request: request);
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