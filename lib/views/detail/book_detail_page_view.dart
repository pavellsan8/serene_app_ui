import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/main/book_page_model.dart';
import '../../viewmodels/detail/book_detail_page_viewmodel.dart';
import '../../widgets/main/book/recommended_card_widget.dart';
// import '../../utils/routes.dart';
import '../../utils/colors.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;
  final List<Book> recommendedBooks;

  const BookDetailPage({
    super.key,
    required this.book,
    required this.recommendedBooks,
  });

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  void initState() {
    super.initState();
    // Check if the book is in favorites when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel =
          Provider.of<BookDetailViewModel>(context, listen: false);
      viewModel.checkFavoriteStatus(widget.book.id);
    });
  }

  @override
  // Not showing the current book id on the recommendation
  Widget build(BuildContext context) {
    final List<Book> filteredRecommendations =
        widget.recommendedBooks.where((b) => b.id != widget.book.id).toList();

    final viewModel = Provider.of<BookDetailViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        title: const Text(
          'Book Detail',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
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
              if (widget.book.thumbnail != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    // viewModel.getHighQualityThumbnail(widget.book.thumbnail),
                    widget.book.thumbnail ?? '',
                    height: 250,
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                widget.book.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.book.authors ?? 'Unknown Author',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.getSubtitleColor(context),
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    color: AppColors.getSubtitleColor(context),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.book.pages?.toString() ?? 'Unknown pages'} Pages',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.getSubtitleColor(context),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.calendar_today_rounded,
                    color: AppColors.getSubtitleColor(context),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Published: ${widget.book.date ?? 'Unknown date'}',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.getSubtitleColor(context),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          String urlString = widget.book.url ?? '';
                          if (urlString.isNotEmpty) {
                            if (!urlString.startsWith('https://') &&
                                !urlString.startsWith('http://')) {
                              urlString = 'https://$urlString';
                            }

                            final Uri url = Uri.parse(urlString);
                            try {
                              bool launched = await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );

                              if (!launched) {
                                debugPrint('Could not launch $url');
                              }
                            } catch (e) {
                              debugPrint('Error launching URL: $e');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Read Now',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () =>
                            viewModel.toggleFavorite(context, widget.book.id),
                        icon: Icon(
                          viewModel.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.book.description ?? 'No description available.',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: AppColors.getFontColor(context),
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: viewModel.isDescriptionExpanded ? null : 7,
                    overflow: viewModel.isDescriptionExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (widget.book.description != null &&
                      (widget.book.description!.length > 300))
                    GestureDetector(
                      onTap: viewModel.toggleDescription,
                      child: Row(
                        children: [
                          const Spacer(),
                          Text(
                            viewModel.isDescriptionExpanded
                                ? 'Read Less'
                                : 'Read More',
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            viewModel.isDescriptionExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: AppColors.primaryColor,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              RecommendedBooksWidget(
                books: filteredRecommendations,
                onBookTap: (book) {
                  // Push lagi halaman detail dengan buku yang berbeda
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailPage(
                        book: book,
                        recommendedBooks: widget.recommendedBooks,
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
