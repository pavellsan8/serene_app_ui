import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/routes.dart';
import '../../../widgets/main/book/search_bar_widget.dart';
import '../../../widgets/main/book/recommended_card_widget.dart';
import '../../../widgets/main/book/regular_card_widget.dart';
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
    await Provider.of<BookPageViewModel>(context, listen: false).initialize();
  }

  void _handleBookTap(Book book) {
    debugPrint("Navigating to: ${book.id}");
    // Add navigation logic here
  }

  void _handleFavoriteTap(Book book) {
    Provider.of<BookPageViewModel>(context, listen: false)
        .toggleFavorite(book.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<BookPageViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == BookPageState.loading &&
              viewModel.allBooks.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
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
                  Stack(
                    children: [
                      ClipPath(
                        child: SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/home/detail/book_ilustration.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.homePage,
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.arrow_back_ios_outlined,
                                size: 32,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Sere',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Read',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 110,
                        left: 20,
                        right: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              'Let go of stress and begin a new chapter.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
