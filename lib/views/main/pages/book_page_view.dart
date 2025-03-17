import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/routes.dart';
import '../../../widgets/main/search_bar_widget.dart';
import '../../../widgets/main/recomended_book_card_widget.dart';
import '../../../widgets/main/regular_book_card_widget.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final TextEditingController searchController = TextEditingController();
  // Set to store favorite book titles
  final Set<String> _favoriteBooks = {};

  final List<Map<String, String>> books = [
    {
      'title': 'The Human Side of Postmortems1',
      'description': 'Managing Stress and Cognitive Biases',
      'author': 'Dave Zwieback',
      'image': 'https://www.dbooks.org/img/books/144936585Xs.jpg'
    },
    {
      'title': 'The Human Side of Postmortems',
      'description': 'Managing Stress and Cognitive Biases',
      'author': 'Dave Zwieback',
      'image': 'https://www.dbooks.org/img/books/144936585Xs.jpg'
    },
    {
      'title': 'The Human Side of Postmortems',
      'description': 'Managing Stress and Cognitive Biases',
      'author': 'Dave Zwieback',
      'image': 'https://www.dbooks.org/img/books/144936585Xs.jpg'
    },
    {
      'title': 'The Human Side of Postmortems',
      'description': 'Managing Stress and Cognitive Biases',
      'author': 'Dave Zwieback',
      'image': 'https://www.dbooks.org/img/books/144936585Xs.jpg'
    },
  ];

  void _handleBookTap(Map<String, String> book) {
    print("Navigating to: ${book['title']}");
    // Add navigation logic here
  }

  void _handleFavoriteTap(Map<String, String> book) {
    final title = book['title']!;
    setState(() {
      // Toggle favorite state
      if (_favoriteBooks.contains(title)) {
        _favoriteBooks.remove(title);
        print("Removed from favorites: $title");
      } else {
        _favoriteBooks.add(title);
        print("Added to favorites: $title");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.homePage);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: SearchBarWidget(
                controller: searchController,
                onChanged: (value) {
                  print("Searching: $value");
                },
              ),
            ),
            const SizedBox(height: 8),
            RecommendedBooksWidget(
              books: books,
              onBookTap: _handleBookTap,
            ),
            const SizedBox(height: 30),
            AllBooksGridWidget(
              books: books,
              onBookTap: _handleBookTap,
              onFavoriteTap: _handleFavoriteTap,
              favoriteBooks: _favoriteBooks,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
