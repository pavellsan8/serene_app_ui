import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/main/video_page_model.dart';
import '../../../viewmodels/detail/video_detail_page_viewmodel.dart';
import '../../../widgets/main/video/video_card_widget.dart';
import '../../../utils/routes.dart';
import '../../../utils/colors.dart';

class VideoDetailPage extends StatefulWidget {
  final Video video;
  final List<Video> recommendedVideos;

  const VideoDetailPage({
    super.key,
    required this.video,
    required this.recommendedVideos,
  });

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    final List<Video> filteredRecommendations = widget.recommendedVideos
        .where((b) => b.videoId != widget.video.videoId)
        .toList();

    final viewModel = Provider.of<VideoDetailViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Video Detail',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
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
            AppRoutes.videoPage,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.video.thumbnail != null)
              ClipRRect(
                child: Image.network(
                  widget.video.thumbnail ?? '',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.video.title ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.video.channel ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.subtitleTextColor,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => viewModel.toggleFavorite(context),
                        icon: Icon(
                          viewModel.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            VideoGridWidget(
              videos: filteredRecommendations,
              onVideoTap: (video) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoDetailPage(
                      video: video,
                      recommendedVideos: widget.recommendedVideos,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
