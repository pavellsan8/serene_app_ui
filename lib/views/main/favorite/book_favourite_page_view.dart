import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/main/book_page_model.dart';
import '../../../viewmodels/favourite/book_favourite_viewmodel.dart';
import '../../../views/main/favorite/favorite_template_view.dart';
import '../../../views/main/detail/book_detail_page_view.dart';
import '../../../widgets/favourite/book_favourite_card_widget.dart';

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
            itemBuilder: (context, books) {
              return BooksFavouriteGridWidget(
                books: books,
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
            shimmerWidget: const BooksFavouriteShimmerGridWidget(),
          );
        },
      ),
    );
  }
}
