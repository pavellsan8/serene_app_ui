import 'package:flutter/material.dart';

import '../../../models/main/book_page_model.dart';
import '../../../widgets/main/book/recommended_card_widget.dart';
import '../../../utils/colors.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;
  final List<Book> recommendedBooks; // Tambahkan ini

  const BookDetailPage({
    super.key,
    required this.book,
    required this.recommendedBooks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Book Detail',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (book.image != null)
                Image.network(
                  book.image!,
                  height: 200,
                ),
              const SizedBox(height: 16),
              Text(
                book.title ?? 'No Title',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                book.authors ?? 'Unknown Author',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                book.description ?? 'No description available.',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 24),

              /// 🔥 Tambahkan RecommendedBooksWidget di sini
              RecommendedBooksWidget(
                books: recommendedBooks,
                onBookTap: (book) {
                  // Push lagi halaman detail dengan buku yang berbeda
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailPage(
                        book: book,
                        recommendedBooks: recommendedBooks,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
