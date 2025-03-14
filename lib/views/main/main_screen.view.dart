import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floating_frosted_bottom_bar/floating_frosted_bottom_bar.dart';

import '../../viewmodels/main/main_screen_viewmodel.dart';
import '../../views/main/pages/home_page_view.dart';
import '../../views/main/pages/music_page_view.dart';
import '../../views/main/pages/video_page_view.dart';
import '../../views/main/pages/book_page_view.dart';
// import '../../views/main/pages/profile_page_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late MainScreenViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = MainScreenViewModel();
    viewModel.initController(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Consumer<MainScreenViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            extendBody: true,
            body: FrostedBottomBar(
              opacity: 0.6,
              sigmaX: 5,
              sigmaY: 5,
              borderRadius: BorderRadius.circular(20),
              child: TabBar(
                controller: viewModel.tabController,
                indicatorColor: Colors.transparent,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(icon: Icon(Icons.home_rounded, size: 30)),
                  Tab(icon: Icon(Icons.music_note_rounded, size: 30)),
                  Tab(icon: Icon(Icons.video_library_rounded, size: 30)),
                  Tab(icon: Icon(Icons.library_books_rounded, size: 30)),
                  // Tab(icon: Icon(Icons.person, size: 30)),
                ],
                onTap: viewModel.changeTab,
              ),
              body: (context, controller) => TabBarView(
                controller: viewModel.tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  HomePage(),
                  MusicPage(),
                  VideoPage(),
                  BookPage(),
                  // ProfilePage(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
