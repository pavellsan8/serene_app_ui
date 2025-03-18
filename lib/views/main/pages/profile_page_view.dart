import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.homePage);
            },
          ),
        ),
      ),
      body: const Center(
        child: Text(
          "Profile Page",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
