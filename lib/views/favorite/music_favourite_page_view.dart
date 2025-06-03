import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/main/music_page_model.dart';
import '../../viewmodels/detail/music_detail_page_viewmodel.dart';
import '../../viewmodels/favourite/music_favourite_viewmodel.dart';
import 'favorite_template_view.dart';
import '../detail/music_detail_page_view.dart';
import '../../widgets/main/music/music_card_widget.dart';

class MusicFavouritesPage extends StatelessWidget {
  const MusicFavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MusicFavoritesViewModel()..fetchFavoriteMusics(),
      child: Consumer<MusicFavoritesViewModel>(
        builder: (context, viewModel, child) {
          return FavoritesPage<Music>(
            appBarTitle: "Favorite Musics",
            items: viewModel.favoriteMusics,
            isLoading: viewModel.isLoading,
            searchPredicate: (music, query) {
              final lowercaseQuery = query.toLowerCase();
              return music.title!.toLowerCase().contains(lowercaseQuery);
            },
            itemBuilder: (context, musics) {
              return MusicGridWidget(
                musics: musics,
                color: Colors.transparent,
                onMusicTap: (music) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => MusicDetailPageViewModel(),
                        child: MusicDetailPage(
                          music: music,
                          playlist: musics,
                          initialIndex: musics.indexWhere(
                            (item) => item.id == music.id,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            shimmerWidget: const MusicShimmerGridWidget(
              showContainer: false,
            ),
          );
        },
      ),
    );
  }
}
