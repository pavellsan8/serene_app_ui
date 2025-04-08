import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/main/book_page_model.dart';
import '../../../viewmodels/detail/book_detail_page_viewmodel.dart';
import '../../../widgets/main/book/recommended_card_widget.dart';
import '../../../utils/routes.dart';
import '../../../utils/colors.dart';

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
  Widget build(BuildContext context) {
    final List<Book> filteredRecommendations = widget.recommendedBooks
        .where((b) => b.title != widget.book.title)
        .toList();

    final viewModel = Provider.of<BookDetailViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Book Detail',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushNamed(
            context,
            AppRoutes.bookPage,
          ),
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
                    viewModel.getHighQualityThumbnail(widget.book.thumbnail),
                    height: 250,
                    width: 150,
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
                widget.book.authorsAsString,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.subtitleTextColor,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.menu_book_rounded,
                    color: AppColors.subtitleTextColor,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.book.pages?.toString() ?? 'Unknown pages'} Pages',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.subtitleTextColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.calendar_today_rounded,
                    color: AppColors.subtitleTextColor,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Published: ${widget.book.date ?? 'Unknown date'}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.subtitleTextColor,
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
                          final Uri url = Uri.parse(widget.book.url ?? '');
                          if (await canLaunchUrl(url)) {
                            debugPrint('URL: ${widget.book.url}');
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          } else {
                            debugPrint('Could not launch $url');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => viewModel.toggleFavorite(context),
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
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
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
