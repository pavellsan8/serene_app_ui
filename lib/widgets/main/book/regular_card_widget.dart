import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../models/main/book_page_model.dart';
import '../../../utils/colors.dart';

class BooksGridWidget extends StatelessWidget {
  final List<Book> books;
  final Color color;
  final Function(Book) onBookTap;

  const BooksGridWidget({
    Key? key,
    required this.books,
    required this.color,
    required this.onBookTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2.4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return GestureDetector(
              onTap: () => onBookTap(book),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: color,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image section
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        book.thumbnail ?? '',
                        height: 200,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 150,
                          width: double.infinity,
                          color: AppColors.getBaseColorShimmer(context),
                          child: const Icon(Icons.book),
                        ),
                      ),
                    ),
                    // Text section
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              book.authors ?? 'Unknown Author',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.subtitleTextColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              book.description ?? 'No description',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.subtitleTextColor,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class BooksShimmerGridWidget extends StatelessWidget {
  final bool showContainer;

  const BooksShimmerGridWidget({
    Key? key,
    required this.showContainer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.getBaseColorShimmer(context),
      highlightColor: AppColors.getHighlightColorShimmer(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Illustration placeholder (top image)
            if (showContainer)
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    color: AppColors.getBaseColorShimmer(context),
                  ),
                  const SizedBox(height: 8),
                ],
              )

            // Placeholder search bar
            else
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.getBaseColorShimmer(context),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

            // Book cards shimmer
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Column(
                children: List.generate(
                  5,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          // Image shimmer
                          Container(
                            height: 150,
                            width: 120,
                            decoration: BoxDecoration(
                              color: AppColors.getBaseColorShimmer(context),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Text shimmer
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title shimmer
                                  Container(
                                    height: 16,
                                    width: double.infinity,
                                    color: AppColors.getBaseColorShimmer(context),
                                  ),
                                  const SizedBox(height: 8),
                                  // Author shimmer
                                  Container(
                                    height: 14,
                                    width: 120,
                                    color: AppColors.getBaseColorShimmer(context),
                                  ),
                                  const SizedBox(height: 12),
                                  // Description lines shimmer
                                  Container(
                                    height: 12,
                                    width: double.infinity,
                                    color: AppColors.getBaseColorShimmer(context),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 12,
                                    width: double.infinity,
                                    color: AppColors.getBaseColorShimmer(context),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 12,
                                    width: 150,
                                    color: AppColors.getBaseColorShimmer(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    // );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
