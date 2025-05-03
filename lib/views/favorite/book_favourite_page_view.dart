import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/main/book_page_model.dart';
import '../../viewmodels/favourite/book_favourite_viewmodel.dart';
import 'favorite_template_view.dart';
import '../detail/book_detail_page_view.dart';
import '../../widgets/main/book/regular_card_widget.dart';

class BookFavouritesPage extends StatelessWidget {
  const BookFavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookFavoritesViewModel()..fetchFavoriteBooks(),
      child: Consumer<BookFavoritesViewModel>(
        builder: (context, viewModel, child) {
          return FavoritesPage<Book>(
            appBarTitle: "Favorite Books",
            items: viewModel.favoriteBooks,
            isLoading: viewModel.isLoading,
            searchPredicate: (book, query) {
              final lowercaseQuery = query.toLowerCase();
              // Search by title
              return book.title.toLowerCase().contains(lowercaseQuery);
            },
            itemBuilder: (context, books) {
              return BooksGridWidget(
                books: books,
                color: Colors.transparent,
                onBookTap: (book) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailPage(
                        book: book,
                        recommendedBooks: viewModel.favoriteBooks,
                      ),
                    ),
                  );
                },
              );
            },
            shimmerWidget: const BooksShimmerGridWidget(
              showContainer: false,
            ),
          );
        },
      ),
    );
  }
}
