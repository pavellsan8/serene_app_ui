import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/about/feature_card_widget.dart';
import '../../widgets/about/team_member_widget.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.getBackgroundColor(context),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo Section
            Center(
              child: Image.asset(
                'assets/images/logo.png', // Replace with your asset path
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.3,
              ),
            ),
            const SizedBox(height: 24),

            // App Name and Tagline
            // const Center(
            //   child: Column(
            //     children: [
            //       Text(
            //         'Serene Mobile App',
            //         style: TextStyle(
            //           fontSize: 28,
            //           fontWeight: FontWeight.bold,
            //           fontFamily: 'Montserrat',
            //           color: AppColors.primaryColor,
            //         ),
            //       ),
            //       SizedBox(height: 8),
            //       Text(
            //         'Your Companion for Mental Health',
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontStyle: FontStyle.italic,
            //           color: Colors.grey,
            //           fontFamily: 'Montserrat',
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 32),

            // About Section
            Text(
              'About This App',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: AppColors.getFontColor(context),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This app is designed to address the mental health needs of users by providing '
              'a set of unique features tailored to support relaxation, emotional wellbeing, '
              'and stress management. Through careful research and user feedback, we aim to offer '
              'an effective and trustworthy solution for mental health support.',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 32),

            // Features Section
            Text(
              'Key Features',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: AppColors.getFontColor(context),
              ),
            ),
            const SizedBox(height: 16),
            FeatureCardAboutWidget(
              image: AppColors.getSerebotPath(context),
              title: 'Chatbot Consultation',
              description:
                  'Share your feelings with an empathetic virtual companion.',
            ),
            const FeatureCardAboutWidget(
              image: 'assets/images/home/menu/serehear.png',
              title: 'Relaxing Music',
              description: 'Curated tracks to ease stress and relax your mind.',
            ),
            const FeatureCardAboutWidget(
              image: 'assets/images/home/menu/serewatch.png',
              title: 'Meditation Videos',
              description: 'Watch calming videos to promote peace and balance.',
            ),
            const FeatureCardAboutWidget(
              image: 'assets/images/home/menu/sereread.png',
              title: 'Book Reading',
              description:
                  'Explore books to uplift your mood and relax your mind.',
            ),
            const SizedBox(height: 32),

            // Goal Section
            Text(
              'Our Goal',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: AppColors.getFontColor(context),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'By combining these features, this app aims to become an effective and reliable solution for users seeking '
              'to improve, maintain, and restore their mental wellbeing.',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 32),

            // Team Section (New)
            Text(
              'Meet the Team',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: AppColors.getFontColor(context),
              ),
            ),
            const SizedBox(height: 16),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    TeamMemberWidget(
                      image: 'assets/images/about/evan.jpg',
                      name: 'Evan Yauris',
                      // role: 'Product Conceptualizer',
                    ),
                    SizedBox(width: 24),
                    TeamMemberWidget(
                      image: 'assets/images/about/nawfal.jpg',
                      name: 'Nawfal Sayeed',
                      // role: 'UI / UX Designer',
                    ),
                    SizedBox(width: 24),
                    TeamMemberWidget(
                      image: 'assets/images/about/pavel.jpg',
                      name: 'Pavel Susanto',
                      // role: 'Application Developer',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Divider for styling
            const Divider(thickness: 1.5),
            const SizedBox(height: 8),

            // Footer Section
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Text(
                    'Thank you for choosing Serene',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Version 1.0 • © 2025 Serene',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Taking small steps toward better mental health, together.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: AppColors.getPrimaryColor(context),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
