import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serene_app/views/detail/music_detail_page_view.dart';

import '../../../models/main/music_page_model.dart';
import '../../../viewmodels/main/music_page_viewmodel.dart';
import '../../../viewmodels/detail/music_detail_page_viewmodel.dart';
import '../../../views/main/template_menu_view.dart';
import '../../../widgets/main/music/music_card_widget.dart';
import '../../../utils/colors.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  @override
  Widget build(BuildContext context) {
    return GenericPage<Music>(
      fetchData: () async {
        final viewModel =
            Provider.of<MusicPageViewModel>(context, listen: false);
        return await viewModel.fetchData();
      },
      image: 'assets/images/home/detail/music_ilustration.jpg',
      feature: 'Hear',
      subtitle: 'Let the music flow in your mind.',
      itemBuilder: (musics) {
        return MusicGridWidget(
          musics: musics,
          color: AppColors.getBackgroundColor(context),
          onMusicTap: (music) {
            final int selectedIndex =
                musics.indexWhere((item) => item.id == music.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => MusicDetailPageViewModel(),
                  child: MusicDetailPage(
                    music: music,
                    playlist: musics, // Pass the entire music list
                    initialIndex: selectedIndex >= 0 ? selectedIndex : 0,
                  ),
                ),
              ),
            );
          },
        );
      },
      loadingBuilder: () => const MusicShimmerGridWidget(
        showContainer: true,
      ),
    );
  }
}
