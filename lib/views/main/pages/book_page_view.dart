import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/routes.dart';
import '../../../widgets/main/search_bar_widget.dart';
import '../../../widgets/main/recommended_book_card_widget.dart';
import '../../../widgets/main/regular_book_card_widget.dart';
import '../../../viewmodels/main/book_page_viewmodel.dart';
import '../../../models/main/book_page_model.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Schedule the initialization for after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final viewModel = Provider.of<BookPageViewModel>(context, listen: false);
    await viewModel.initialize();
  }

  void _handleBookTap(Book book) {
    print("Navigating to: ${book.id}");
    // Add navigation logic here
  }

  void _handleFavoriteTap(Book book) {
    final viewModel = Provider.of<BookPageViewModel>(context, listen: false);
    viewModel.toggleFavorite(book.id);
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
      body: Consumer<BookPageViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == BookPageState.loading &&
              viewModel.allBooks.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.state == BookPageState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${viewModel.errorMessage}'),
                  ElevatedButton(
                    onPressed: () => viewModel.refreshBooks(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: viewModel.refreshBooks,
            child: SingleChildScrollView(
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
                        viewModel.searchBooks(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  RecommendedBooksWidget(
                    books: viewModel.allBooks,
                    onBookTap: _handleBookTap,
                  ),
                  const SizedBox(height: 30),
                  AllBooksGridWidget(
                    books: viewModel.allBooks,
                    onBookTap: _handleBookTap,
                    onFavoriteTap: _handleFavoriteTap,
                    favoriteBooks: viewModel.favoriteBooks,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
