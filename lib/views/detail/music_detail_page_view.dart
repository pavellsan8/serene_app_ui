import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/main/music_page_model.dart';
import '../../viewmodels/detail/music_detail_page_viewmodel.dart';
import '../../widgets/main/music/music_image_vinyl_widget.dart';
import '../../utils/routes.dart';
import '../../utils/colors.dart';

class MusicDetailPage extends StatefulWidget {
  final Music music;
  final List<Music>? playlist;
  final int initialIndex;

  const MusicDetailPage({
    super.key,
    required this.music,
    this.playlist,
    this.initialIndex = 0,
  });

  @override
  State<MusicDetailPage> createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel =
          Provider.of<MusicDetailPageViewModel>(context, listen: false);

      viewModel.checkFavoriteStatus(widget.music.id);

      // Set playlist if available
      if (widget.playlist != null && widget.playlist!.isNotEmpty) {
        viewModel.setPlaylist(widget.playlist!, widget.initialIndex);
        debugPrint("Setting playlist with ${widget.playlist!.length} tracks");

        // Play the initial track if it has an audio URL
        if (widget.initialIndex < widget.playlist!.length &&
            widget.playlist![widget.initialIndex].audio != null &&
            widget.playlist![widget.initialIndex].audio!.isNotEmpty) {
          viewModel.playTrackAtIndex(widget.initialIndex);
        }
      } else {
        // Fallback to single track mode
        if (widget.music.audio != null && widget.music.audio!.isNotEmpty) {
          debugPrint("Calling playMusic with link: ${widget.music.audio}");
          viewModel.setPlaylist([widget.music], 0);
          viewModel.playMusic(widget.music.audio!);
        } else {
          debugPrint("No audio link available");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MusicDetailPageViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
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
            Icons.arrow_back_ios_new_rounded,
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
            child: RotatingDisc(
              imageUrl:
                  viewModel.currentMusic?.thumbnail ?? 'default_thumbnail_url',
            ),
            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(8),
            //   child: Image.network(
            //     widget.music.thumbnail ?? 'default_thumbnail_url',
            //     fit: BoxFit.cover,
            //     errorBuilder: (context, error, stackTrace) => Container(
            //       height: MediaQuery.of(context).size.height * 0.15,
            //       width: MediaQuery.of(context).size.width * 0.2,
            //       color: Colors.grey[300],
            //       child: const Icon(Icons.book),
            //     ),
            //   ),
            // ),
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
                              viewModel.currentMusic?.title ?? 'Unknown Title',
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
                              viewModel.currentMusic?.artist ??
                                  'Unknown Artist',
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
                          viewModel.toggleFavorite(context, widget.music.id);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Slider and Time Indicators
                  Column(
                    children: [
                      Slider(
                        value: viewModel.currentPosition.inSeconds.toDouble(),
                        max: viewModel.duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          viewModel.seekTo(Duration(seconds: value.toInt()));
                        },
                        activeColor: Colors.white,
                        inactiveColor: Colors.white38,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            viewModel.formatDuration(viewModel.currentPosition),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Text(
                            viewModel.currentMusic?.duration ??
                                'Unknown Duration',
                            style: const TextStyle(
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
                          viewModel.toggleShuffle(); // Toggle shuffle
                        },
                        icon: Icon(
                          Icons.shuffle_rounded,
                          color:
                              viewModel.isShuffle ? Colors.amber : Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          viewModel.playPrevious(); // Play previous track
                        },
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          viewModel.togglePlaying(); // Toggle play/pause
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
                          viewModel.playNext(); // Play next track
                        },
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          viewModel.toggleRepeat(); // Toggle repeat
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
