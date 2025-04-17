import 'package:flutter/material.dart';

import '../../utils/shared_preferences.dart';

class FavouritesViewModel extends ChangeNotifier {
  bool isFavorite = false; // Status favorite
  bool isLoading = true; // Status loading

  Future<void> checkFavouriteStatus(String itemId, String itemType) async {
    final email = await ApplicationStorage.getEmail();
    if (email == null) {
      throw Exception("User not logged in");
    }

    try {
      // bool result;

      // Pilih API berdasarkan jenis item
      // switch (itemType) {
      //   case "book":
      //     result = await bookFavouriteService.isBookFavourite(itemId, email);
      //     break;
      //   case "music":
      //     result = await musicFavouriteService.isMusicFavourite(itemId, email);
      //     break;
      //   case "video":
      //     result = await videoFavouriteService.isVideoFavourite(itemId, email);
      //     break;
      //   default:
      //     throw Exception("Unsupported item type");
      // }

      // isFavorite = result;
    } catch (e) {
      debugPrint("Error checking favorite status for $itemType: $e");
      throw Exception("Failed to check favorite status for $itemType");
    }

    isLoading = false;
    notifyListeners();
  }
}
