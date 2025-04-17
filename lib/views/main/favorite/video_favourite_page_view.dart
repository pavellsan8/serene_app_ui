import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/main/video_page_model.dart';
import '../../../viewmodels/favourite/video_favourite_viewmodel.dart';
import '../../../views/main/favorite/favorite_template_view.dart';
import '../../../views/main/detail/video_detail_page_view.dart';
import '../../../widgets/main/video/video_card_widget.dart';

class VideoFavouritesPage extends StatelessWidget {
  const VideoFavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoFavoritesViewModel()..fetchFavoriteVideos(),
      child: Consumer<VideoFavoritesViewModel>(
        builder: (context, viewModel, child) {
          return FavoritesPage<Video>(
            appBarTitle: "Favorite Videos",
            items: viewModel.favoriteVideos,
            isLoading: viewModel.isLoading,
            itemBuilder: (context, videos) {
              return VideoGridWidget(
                videos: videos,
                color: Colors.transparent,
                onVideoTap: (video) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoDetailPage(
                        video: video,
                        recommendedVideos: viewModel.favoriteVideos,
                      ),
                    ),
                  );
                },
              );
            },
            shimmerWidget: const VideoShimmerGridWidget(
              showContainer: false,
            ),
          );
        },
      ),
    );
  }
}
