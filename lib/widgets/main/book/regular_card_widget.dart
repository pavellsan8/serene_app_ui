import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../models/main/book_page_model.dart';
import '../../../utils/colors.dart';

class BooksGridWidget extends StatelessWidget {
  final List<Book> books;
  final Function(Book) onBookTap;

  const BooksGridWidget({
    Key? key,
    required this.books,
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
            childAspectRatio: 2.5,
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
                color: AppColors.backgroundColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image section
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      child: Image.network(
                        book.image ?? '',
                        height: 200,
                        width: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 150,
                          width: double.infinity,
                          color: Colors.grey[300],
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
                              book.title ?? 'Unknown Title',
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
  const BooksShimmerGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Illustration placeholder (top image)
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),

            // Book cards shimmer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: List.generate(4, (index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        // Image shimmer
                        Container(
                          height: 140,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
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
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 8),
                                // Author shimmer
                                Container(
                                  height: 14,
                                  width: 120,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 12),
                                // Description lines shimmer
                                Container(
                                  height: 12,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  height: 12,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  height: 12,
                                  width: 150,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
