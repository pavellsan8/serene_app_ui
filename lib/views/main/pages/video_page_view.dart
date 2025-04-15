import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/main/video_page_model.dart';
import '../../../viewmodels/main/video_page_viewmodel.dart';
import '../../../views/main/template_menu_view.dart';
import '../../../views/main/detail/video_detail_page_view.dart';
import '../../../widgets/main/video/video_card_widget.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return GenericPage<Video>(
      fetchData: () async {
        final viewModel =
            Provider.of<VideoPageViewModel>(context, listen: false);
        return await viewModel.fetchData();
      },
      image: 'assets/images/home/detail/video_ilustration.jpg',
      feature: 'Watch',
      subtitle: 'Let the calm flow through your gaze.',
      // Pass your custom widget to itemBuilder
      itemBuilder: (videos) {
        return VideoGridWidget(
          videos: videos,
          onVideoTap: (video) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoDetailPage(
                  video: video,
                  recommendedVideos: videos,
                ),
              ),
            );
          },
        );
      },
      loadingBuilder: () => const VideoShimmerGridWidget(),
    );
  }
}
