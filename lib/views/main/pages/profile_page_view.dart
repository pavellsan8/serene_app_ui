import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/main/profile_page_viewmodel.dart';
import '../../../widgets/main/profile_card_widget.dart';
import '../../../widgets/main/emotion_chip_widget.dart';
import '../../../utils/colors.dart';

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

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Text(
                            getInitials('Your Name'),
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
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: Stack(
                            children: [
                              Wrap(
                                alignment: WrapAlignment.center,
                                runSpacing: 10,
                                spacing: 8,
                                children: emotionList
                                    .map(
                                      (emotion) =>
                                          EmotionChipWidget(label: emotion),
                                    )
                                    .toList(),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: 36,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.settings_outlined,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF37474F),
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
                                ),
                                ProfileInfoCard(
                                  icon: Icons.phone,
                                  title: "Phone number",
                                  subtitle: profileViewModel.userData!.phoneNum,
                                ),
                                const SizedBox(height: 20),
                                const ProfileInfoCard(
                                  icon: Icons.logout,
                                  title: "Log out",
                                  subtitle: "Change your account",
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
