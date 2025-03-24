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
                  child: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/home/home_ilustration.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned(
                  top: 50,
                  left: 20,
                  right: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Embrace a sense of peace in every step you take.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Give yourself the time to truly feel the serenity within.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
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
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),

            // Main grid menu
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.1,
                children: [
                  CardItem(
                    title: "Sere" "bot",
                    path: "assets/images/home/menu/serebot.png",
                    color: Colors.red.shade400,
                    route: AppRoutes.chatbotPage,
                    description: "Talk to our chatbot for support and advice.",
                  ),
                  CardItem(
                    title: "Sere" "hear",
                    path: "assets/images/home/menu/serehear.png",
                    color: Colors.blue.shade400,
                    route: AppRoutes.musicPage,
                    description: "Listen to calming music for relaxation.",
                  ),
                  CardItem(
                    title: "Sere" "watch",
                    path: "assets/images/home/menu/serewatch.png",
                    color: Colors.green.shade400,
                    route: AppRoutes.videoPage,
                    description: "Watch videos that help you relax.",
                  ),
                  CardItem(
                    title: "Sere" "read",
                    path: "assets/images/home/menu/sereread.png",
                    color: Colors.orange.shade400,
                    route: AppRoutes.bookPage,
                    description: "Read books that bring calm and peace.",
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
