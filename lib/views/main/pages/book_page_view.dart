import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/main/book_page_model.dart';
import '../../../viewmodels/main/book_page_viewmodel.dart';
import '../../../views/main/template_menu_view.dart';
import '../../detail/book_detail_page_view.dart';
import '../../../widgets/main/book/regular_card_widget.dart';
import '../../../utils/colors.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return GenericPage<Book>(
      fetchData: () async {
        final viewModel =
            Provider.of<BookPageViewModel>(context, listen: false);
        return await viewModel.fetchData();
      },
      image: 'assets/images/home/detail/book_ilustration.jpg',
      feature: 'Read',
      subtitle: 'Let go of stress and begin a new chapter.',
      itemBuilder: (books) {
        return BooksGridWidget(
          books: books,
          color: AppColors.getBackgroundColor(context),
          onBookTap: (book) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailPage(
                  book: book,
                  recommendedBooks: books,
                ),
              ),
            );
          },
        );
      },
      loadingBuilder: () => const BooksShimmerGridWidget(
        showContainer: true,
      ),
    );
  }
}
