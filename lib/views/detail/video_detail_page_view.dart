import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../models/main/video_page_model.dart';
import '../../viewmodels/detail/video_detail_page_viewmodel.dart';
import '../../widgets/main/video/video_card_widget.dart';
import '../../utils/routes.dart';
import '../../utils/colors.dart';

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
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video.ytLink ?? '')!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    // Get ViewModel and initialize it with the controller
    final viewModel = Provider.of<VideoDetailViewModel>(context, listen: false);
    viewModel.setPortraitOrientation();
    viewModel.setYoutubeController(_youtubeController);
    viewModel.checkFavoriteStatus(widget.video.videoId);
  }

  @override
  void dispose() {
    // Clean up in the ViewModel
    Provider.of<VideoDetailViewModel>(context, listen: false)
        .disposeYoutubeController();
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<VideoDetailViewModel>(context);
    final List<Video> filteredRecommendations = widget.recommendedVideos
        .where((b) => b.videoId != widget.video.videoId)
        .toList();

    // Get the screen size to adjust player dimensions
    // final screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return viewModel.handleBackButton();
      },
      child: Scaffold(
        // Only show AppBar when NOT in fullscreen mode
        appBar: viewModel.isFullScreen
            ? null
            : AppBar(
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
        backgroundColor: AppColors.backgroundColor,
        body: viewModel.isFullScreen
            ? YoutubePlayer(
                controller: _youtubeController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: AppColors.primaryColor,
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    YoutubePlayer(
                      controller: _youtubeController,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: AppColors.primaryColor,
                      // progressColors: const ProgressBarColors(
                      //   playedColor: Colors.blue,
                      //   handleColor: Colors.red,
                      //   bufferedColor: Colors.grey,
                      //   backgroundColor: Colors.black,
                      // ),
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
                                      maxLines: 2,
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
                                onPressed: () => viewModel.toggleFavorite(
                                  context,
                                  widget.video.videoId,
                                ),
                                icon: Icon(
                                  viewModel.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded,
                                  color: AppColors.primaryColor,
                                  size: 28,
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
                      color: AppColors.backgroundColor,
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
      ),
    );
  }
}
