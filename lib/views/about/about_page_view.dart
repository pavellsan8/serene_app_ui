import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
            const SizedBox(height: 24.0),

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
            //       SizedBox(height: 8.0),
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
            // const SizedBox(height: 32.0),

            // About Section
            const Text(
              'About This App',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
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
            const SizedBox(height: 16.0),

            // Features Section
            const Text(
              'Key Features',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),

            _buildFeatureCard(
              icon: Icons.chat_bubble_outline,
              title: 'Chatbot Consultation',
              description:
                  'Share your feelings with an empathetic virtual companion.',
            ),
            _buildFeatureCard(
              icon: Icons.music_note,
              title: 'Relaxing Music',
              description: 'Curated tracks to ease stress and relax your mind.',
            ),
            _buildFeatureCard(
              icon: Icons.video_collection,
              title: 'Relaxation Videos',
              description: 'Watch calming videos to promote peace and balance.',
            ),
            _buildFeatureCard(
              icon: Icons.book,
              title: 'Calming Reads',
              description:
                  'Explore books to uplift your mood and relax your mind.',
            ),
            const SizedBox(height: 32.0),

            // Goal Section
            const Text(
              'Our Goal',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'By combining these features, this app aims to become an effective and reliable solution for users seeking '
              'to improve, maintain, and restore their mental wellbeing.',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 32.0),

            // Divider for styling
            const Divider(thickness: 1.5),
            const SizedBox(height: 16.0),

            // Footer Section
            const Center(
              child: Text(
                'Thank you for using Serene Mobile App',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            const Center(
              child: Text(
                'Together, we can build a better state of mind.',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: AppColors.primaryColor,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a feature card
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryColor, size: 32.0),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
