import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/main/profile_page_viewmodel.dart';
import '../../../widgets/main/profile_card_widget.dart';
import '../../../utils/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Fetch user profile when the widget is initialized
    Future.microtask(() {
      Provider.of<UserProfileViewModel>(context, listen: false)
          .fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<UserProfileViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              : profileViewModel.userData == null
                  ? const Center(
                      child: Text(
                        "No user data available.",
                        style: TextStyle(
                            color: AppColors.fontBlackColor, fontSize: 18),
                      ),
                    )
                  : Column(
                      children: [
                        const SizedBox(height: 30),
                        const SizedBox(height: 16),
                        Text(
                          profileViewModel.userData!.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.fontBlackColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 2,
                                    vertical: 5,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.settings,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
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
                                  icon: Icons.person_add,
                                  title: "Add account",
                                  subtitle: "Login or add another account",
                                ),
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
