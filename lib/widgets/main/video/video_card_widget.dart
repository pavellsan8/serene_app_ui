import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../models/main/video_page_model.dart';
import '../../../utils/colors.dart';

class VideoGridWidget extends StatelessWidget {
  final List<Video> videos;
  final Color color;
  final Function(Video) onVideoTap;

  const VideoGridWidget({
    Key? key,
    required this.videos,
    required this.color,
    required this.onVideoTap,
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
            childAspectRatio: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
          ),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return GestureDetector(
              onTap: () => onVideoTap(video),
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
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: Image.network(
                        video.thumbnail ?? '',
                        height: 80,
                        width: 140,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 150,
                          width: double.infinity,
                          color: AppColors.getBaseColorShimmer(context),
                          child: const Icon(Icons.video_collection_rounded),
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
                            // const SizedBox(height: 6),
                            Text(
                              video.title ?? 'Unknown Title',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  (video.channel?.length ?? 0) > 14
                                      ? '${video.channel!.substring(0, 14)}...'
                                      : video.channel ?? 'No channel',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.subtitleTextColor,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.circle,
                                  size: 6,
                                  color: AppColors.subtitleTextColor,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  video.duration ?? 'No duration',
                                  maxLines: 1,
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

class VideoShimmerGridWidget extends StatelessWidget {
  final bool showContainer;

  const VideoShimmerGridWidget({
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

            // Video cards shimmer
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: List.generate(
                  10,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          // Image shimmer
                          Container(
                            height: 70,
                            width: 150,
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
                                    color:
                                        AppColors.getBaseColorShimmer(context),
                                  ),
                                  const SizedBox(height: 8),
                                  // Description lines shimmer
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 12,
                                          color: AppColors.getBaseColorShimmer(
                                              context),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 12,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      const Expanded(
                                        flex: 1,
                                        child: SizedBox.shrink(),
                                      ),
                                    ],
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
