import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/main/music_page_model.dart';
import '../../viewmodels/favourite/music_favourite_viewmodel.dart';
import 'favorite_template_view.dart';
import '../main/detail/music_detail_page_view.dart';
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
              // Search by title
              return music.title!.toLowerCase().contains(lowercaseQuery);
            },
            itemBuilder: (context, books) {
              return MusicGridWidget(
                musics: books,
                color: Colors.transparent,
                onMusicTap: (music) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MusicDetailPage(
                        music: music,
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
