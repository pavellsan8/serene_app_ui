import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/main/profile_page_viewmodel.dart';
import '../../../widgets/main/profile_card_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF546E7A),
      body: Column(
        children: [
          const SizedBox(height: 30),
          CircleAvatar(
            radius: 50,
            backgroundImage:
                NetworkImage(profileViewModel.profile.profileImageUrl),
          ),
          const SizedBox(height: 16),
          Text(
            profileViewModel.profile.name,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: [
                  ...profileViewModel.profile.moods.map((mood) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 8,
                      ),
                      child: Chip(
                        label: Text(
                          mood,
                          style: const TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    );
                  }).toList(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
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
                    subtitle: profileViewModel.profile.email,
                  ),
                  ProfileInfoCard(
                    icon: Icons.calendar_today,
                    title: "Date of birth",
                    subtitle: profileViewModel.profile.dateOfBirth,
                  ),
                  ProfileInfoCard(
                    icon: Icons.phone,
                    title: "Phone number",
                    subtitle: profileViewModel.profile.phoneNumber,
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
