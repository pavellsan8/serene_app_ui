import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/main/profile_page_viewmodel.dart';
import '../../../viewmodels/auth/logout_viewmodel.dart';
import '../../../widgets/main/profile/profile_card_widget.dart';
import '../../../widgets/main/profile/emotion_chip_widget.dart';
import '../../../utils/colors.dart';
import '../../../utils/routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final emotionList = [
    "Peaceful",
    "Pessimistic",
    "Joyful",
    "Sad",
    "Overwhelmed",
  ];

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
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: AppColors.primaryColor,
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.homePage);
          },
        ),
      ),
      body: profileViewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
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
                      children: [
                        const SizedBox(height: 50),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Text(
                            getInitials(profileViewModel.userData!.name),
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          profileViewModel.userData!.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.fontBlackColor,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            runSpacing: 10,
                            spacing: 8,
                            children: emotionList
                                .map(
                                  (emotion) => EmotionChipWidget(
                                    label: emotion,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                ProfileInfoCard(
                                  icon: Icons.email,
                                  title: "Email address",
                                  subtitle: profileViewModel.userData!.email,
                                  onTap: null,
                                ),
                                ProfileInfoCard(
                                  icon: Icons.logout,
                                  title: "Log out",
                                  subtitle: "Change your account",
                                  onTap: logoutViewModel.isLoading
                                      ? null
                                      : () {
                                          logoutViewModel.logout(context);
                                        },
                                  trailing: logoutViewModel.isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : null,
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
