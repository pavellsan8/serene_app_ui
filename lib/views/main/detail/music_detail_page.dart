import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/main/music_page_model.dart';
import '../../../viewmodels/detail/music_detail_page_viewmodel.dart';
import '../../../utils/routes.dart';
import '../../../utils/colors.dart';

class MusicDetailPage extends StatefulWidget {
  final Music music;

  const MusicDetailPage({
    super.key,
    required this.music,
  });

  @override
  State<MusicDetailPage> createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  String highResThumbnail(String url) {
    return url.replaceFirst(RegExp(r'w\d+-h\d+'), 'w500-h500');
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MusicDetailPageViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Music Player",
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
            AppRoutes.musicPage,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 72,
              horizontal: 32,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                highResThumbnail(
                    widget.music.thumbnail ?? 'default_thumbnail_url'),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.2,
                  color: Colors.grey[300],
                  child: const Icon(Icons.book),
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            color: AppColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.music.title ?? 'Unknown Title',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.music.artist ?? 'Unknown Artist',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: Icon(
                          viewModel.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: viewModel.isFavorite
                              ? Colors.white
                              : Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          viewModel.toggleFavoriteStatus();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Slider and Time Indicators
                  Column(
                    children: [
                      Slider(
                        value: 0.1, // Replace with current position value
                        onChanged: (value) {
                          // Add slider change functionality
                        },
                        activeColor: Colors.white,
                        inactiveColor: Colors.white38,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "1:15", // Replace with current time
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Text(
                            "5:15", // Replace with total duration
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Playback Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Shuffle functionality
                        },
                        icon: const Icon(
                          Icons.shuffle_rounded,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Previous track functionality
                        },
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          viewModel.togglePlaying(); // Toggle play/pause
                          // Add functionality to play or pause music here
                        },
                        icon: Icon(
                          viewModel.isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded, // Toggle icon
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Next track functionality
                        },
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          viewModel.toggleRepeat(); // Toggle repeat
                          // Repeat functionality
                        },
                        icon: Icon(
                          viewModel.isRepeat
                              ? Icons.repeat_one_rounded
                              : Icons.repeat_rounded,
                          color: Colors.white,
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
    );
  }
}
