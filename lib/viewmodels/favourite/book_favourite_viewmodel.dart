import 'package:flutter/material.dart';

import '../../models/main/book_page_model.dart';
import '../../services/favourite/book_favourite_service.dart';
import '../../utils/shared_preferences.dart';

class BookFavoritesViewModel extends ChangeNotifier {
  final BookFavouriteService _bookFavouriteService = BookFavouriteService();
  bool isLoading = true;
  List<Book> favoriteBooks = [];

  Future<void> fetchFavoriteBooks() async {
    try {
      final email = await ApplicationStorage.getEmail();
      debugPrint("Fetching favorite books for email: $email");

      final response = await _bookFavouriteService.getBookData(email: email);
      debugPrint("Books found: ${response.data.length}");

      favoriteBooks = response.data;
    } catch (e) {
      debugPrint("Error fetching favorite books: $e");
      favoriteBooks = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
