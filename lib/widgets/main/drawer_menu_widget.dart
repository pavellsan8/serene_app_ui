import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/routes.dart';
import '../../../viewmodels/auth/logout_viewmodel.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  String getInitials(String name) {
    List<String> nameParts = name.split(" ");
    String initials = nameParts.map((e) => e[0]).take(2).join();
    return initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: AppColors.primaryColor,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            alignment: Alignment.bottomLeft,
            height: 150,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.backgroundColor,
                      child: Text(
                        getInitials('Your Name'),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Your Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 10),
                _buildDrawerItem(
                  icon: Icons.home_outlined,
                  text: 'Home',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.person_outline_rounded,
                  text: 'Profile',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.profilePage);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.music_note_rounded,
                  text: 'Music',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.musicPage);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.video_collection_outlined,
                  text: 'Video',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.videoPage);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.menu_book_rounded,
                  text: 'Books',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.bookPage);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.chat_outlined,
                  text: 'Chatbot',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.chatbotPage);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.favorite_outline_rounded,
                  text: 'Favorites',
                  onTap: () {},
                ),
                _buildDrawerItem(
                  icon: Icons.info_outline_rounded,
                  text: 'About Us',
                  onTap: () {},
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
          _buildDrawerItem(
            icon: Icons.logout_rounded,
            text: 'Logout',
            onTap: () async {
              final loginViewModel = context.read<LogoutViewModel>();
              await loginViewModel.logout(context);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
