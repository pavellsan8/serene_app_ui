import 'package:flutter/material.dart';

import '../../models/main/book_page_model.dart';
import '../../../services/main/book_page_service.dart';

enum BookPageState {
  initial,
  loading,
  loaded,
  error,
}

class BookPageViewModel extends ChangeNotifier {
  final BookService _bookService = BookService();

  // State management
  BookPageState _state = BookPageState.initial;
  String? _errorMessage;

  // Data
  List<Book> _allBooks = [];
  List<Book> _filteredBooks = [];
  final Set<String> _favoriteBooks = {};

  // Getters
  BookPageState get state => _state;
  String? get errorMessage => _errorMessage;
  List<Book> get allBooks => _filteredBooks.isEmpty && _searchQuery.isEmpty
      ? _allBooks
      : _filteredBooks;
  Set<String> get favoriteBooks => _favoriteBooks;

  // Search functionality
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // Initialize the ViewModel
  Future<void> initialize() async {
    // Check if we've already initialized
    if (_state == BookPageState.initial || _state == BookPageState.error) {
      await fetchBooks();
    }
  }

  // Fetch books from the service
  Future<void> fetchBooks() async {
    _state = BookPageState.loading;
    notifyListeners();

    try {
      final BookResponse response = await _bookService.getBookData();
      _allBooks = response.data ?? [];
      _state = BookPageState.loaded;
    } catch (e) {
      _state = BookPageState.error;
      _errorMessage = e.toString();
    }

    // Make sure to notify listeners after the try/catch block
    notifyListeners();
  }

  // Search books
  void searchBooks(String query) {
    _searchQuery = query;

    if (query.isEmpty) {
      _filteredBooks = [];
    } else {
      _filteredBooks = _allBooks.where((book) {
        final titleMatch =
            book.title?.toLowerCase().contains(query.toLowerCase()) ?? false;
        final authorMatch =
            book.authors?.toLowerCase().contains(query.toLowerCase()) ?? false;
        return titleMatch || authorMatch;
      }).toList();
    }

    notifyListeners();
  }

  // Toggle favorite status
  void toggleFavorite(String bookId) {
    if (_favoriteBooks.contains(bookId)) {
      _favoriteBooks.remove(bookId);
    } else {
      _favoriteBooks.add(bookId);
    }
    notifyListeners();
  }

  // Check if a book is favorited
  bool isFavorite(String bookId) {
    return _favoriteBooks.contains(bookId);
  }

  // Refresh book data
  Future<void> refreshBooks() async {
    await fetchBooks();
  }

  // Clean up resources
  @override
  void dispose() {
    super.dispose();
  }
}
