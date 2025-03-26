import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/main/book_page_model.dart';
import '../../../viewmodels/main/book_page_viewmodel.dart';
import '../../../views/main/template_menu_view.dart';
import '../../../widgets/main/book/regular_card_widget.dart';

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
        // Ensure that fetchBooks() returns a Future<List<Book>>
        return await viewModel.fetchData(); // Correctly fetch data
      },
      image: 'assets/images/home/detail/book_ilustration.jpg',
      feature: 'Read',
      subtitle: 'Let go of stress and begin a new chapter.',
      // Pass your custom widget to itemBuilder
      itemBuilder: (books) {
        return AllBooksGridWidget(
          books: books,
          onBookTap: (book) {
            debugPrint("book clicked");
            // Handle book tap
          },
        );
      },
    );
  }
}
