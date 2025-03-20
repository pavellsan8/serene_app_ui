import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/routes.dart';
import '../../widgets/main/card_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  // clipper: BottomCurveClipper(),
                  child: Image.asset(
                    'assets/images/home/home_ilustration.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                  top: 20,
                  left: 10,
                  right: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Embrace a sense of peace in every step you take.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Give yourself the time to truly feel the serenity within.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 15,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.profilePage,
                      );
                    },
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.backgroundColor,
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: 32,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(
                      "Choose the best way to calm your mind!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Calm it with our chatbot, whether through music, reading, or relaxing videos.",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main grid menu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1,
                children: [
                  CardItem(
                    title: "Serehear",
                    icon: Icons.music_note_rounded,
                    color: Colors.blue.shade400,
                    route: AppRoutes.musicPage,
                    description: "Listen to calming music for relaxation",
                  ),
                  CardItem(
                    title: "Serewatch",
                    icon: Icons.video_library_rounded,
                    color: Colors.green.shade400,
                    route: AppRoutes.videoPage,
                    description: "Watch therapy and meditation videos",
                  ),
                  CardItem(
                    title: "Sereread",
                    icon: Icons.book_rounded,
                    color: Colors.orange.shade400,
                    route: AppRoutes.bookPage,
                    description: "Read books about mental health",
                  ),
                  CardItem(
                    title: "Serebot",
                    icon: Icons.chat_bubble_rounded,
                    color: Colors.red.shade400,
                    route: AppRoutes.chatbotPage,
                    description: "Talk to our virtual assistant",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
