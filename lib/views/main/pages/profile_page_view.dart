import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/main/profile_page_viewmodel.dart';
import '../../../viewmodels/auth/logout_viewmodel.dart';
import '../../../widgets/main/profile/profile_card_widget.dart';
import '../../../widgets/main/profile/logout_dialog_widget.dart';
import '../../../utils/colors.dart';
import '../../../utils/routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        Provider.of<UserProfileViewModel>(context, listen: false)
            .fetchUserProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String getInitials(String name) {
      List<String> nameParts = name.split(" ");
      String initials = nameParts.map((e) => e[0]).take(2).join();
      return initials.toUpperCase();
    }

    final profileViewModel = Provider.of<UserProfileViewModel>(context);
    final logoutViewModel = Provider.of<LogoutViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.homePage);
          },
        ),
      ),
      body: profileViewModel.isLoading
          ? const Center(
              child: ProfileInfoShimmerCardWidget(),
            )
          : profileViewModel.errorMessage != null
              ? Center(
                  child: Text(
                    profileViewModel.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                )
              : profileViewModel.userData == null
                  ? const Center(
                      child: Text(
                        "No user data available.",
                        style: TextStyle(
                          color: AppColors.fontBlackColor,
                          fontSize: 18,
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          // margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.grey.shade400,
                                width: 0.5,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey.shade400,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 30,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor:
                                          AppColors.backgroundColor,
                                      child: Text(
                                        getInitials(
                                            profileViewModel.userData!.name),
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          profileViewModel.userData!.name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.fontBlackColor,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        Text(
                                          profileViewModel.userData!.email,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.subtitleTextColor,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade400,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "Playlists",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.fontBlackColor,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                ProfileInfoCardWidget(
                                  icon: Icons.video_library_outlined,
                                  title: "Favorites Videos",
                                  subtitle: "Playlist of video that you like",
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.videoFavourite,
                                    );
                                  },
                                ),
                                ProfileInfoCardWidget(
                                  icon: Icons.music_note_outlined,
                                  title: "Favorites Musics",
                                  subtitle: "Playlist of music that you like",
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.musicFavourite,
                                    );
                                  },
                                ),
                                ProfileInfoCardWidget(
                                  icon: Icons.book_outlined,
                                  title: "Favorites Books",
                                  subtitle: "Playlist of book that you like",
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.bookFavourite,
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Others",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.fontBlackColor,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        ProfileInfoCardWidget(
                          icon: Icons.info_outline_rounded,
                          title: "About Us",
                          subtitle: "Get to know us better",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.aboutPage,
                            );
                          },
                        ),
                        ProfileInfoCardWidget(
                          icon: Icons.logout,
                          title: "Log out",
                          subtitle: "Change your account",
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return LogoutDialog(
                                  onConfirm: logoutViewModel.isLoading
                                      ? null
                                      : () {
                                          logoutViewModel.logout(context);
                                        },
                                  onCancel: () {
                                    Navigator.of(context).pop();
                                  },
                                  isLoading: logoutViewModel.isLoading,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
    );
  }
}
