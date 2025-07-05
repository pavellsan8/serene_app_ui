import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/routes.dart';
import '../../widgets/main/card_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size to use for responsive calculations
    final Size screenSize = MediaQuery.of(context).size;
    final double height = screenSize.height;
    final double width = screenSize.width;

    // Calculate responsive values
    final double bannerHeight = height * 0.45; // 45% of screen height
    final double topPadding = height * 0.06; // 6% of screen height
    final bool isSmallScreen = width < 360; // For very small devices

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  child: SizedBox(
                    height: bannerHeight,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/home/home_ilustration.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: topPadding,
                  left: width * 0.05, // 5% of screen width
                  right: width * 0.3, // 30% of screen width
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Embrace a sense of peace in every step you take.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 14 : 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: height * 0.005), // 0.5% of screen height
                      Text(
                        'Give yourself the time to truly feel the serenity within.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 14 : 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: topPadding,
                  right: width * 0.05, // 5% of screen width
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.profilePage,
                      );
                    },
                    child: CircleAvatar(
                      radius: width * 0.06, // 6% of screen width
                      backgroundColor: AppColors.backgroundColor,
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: width * 0.08, // 8% of screen width
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(
                width * 0.04, // 4% of screen width
                height * 0.02, // 2% of screen height
                width * 0.04, // 4% of screen width
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose the best way to calm your mind!",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.getFontColor(context),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: height * 0.01), // 1% of screen height
                  Text(
                    "Calm it with our chatbot, whether through music, reading, or relaxing videos.",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.getFontColor(context),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),

            // Main grid menu - Responsive grid
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, // 4% of screen width
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Determine the best grid layout based on available width
                  final double availableWidth = constraints.maxWidth;
                  final int crossAxisCount = availableWidth > 600 ? 3 : 2;
                  final double aspectRatio =
                      availableWidth > 600 ? 1.3 : (isSmallScreen ? 0.9 : 1.1);

                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing:
                        availableWidth * 0.04, // 4% of available width
                    mainAxisSpacing:
                        availableWidth * 0.04, // 4% of available width
                    childAspectRatio: aspectRatio,
                    children: [
                      CardItem(
                        title: "Sere" "Bot",
                        width: availableWidth * 0.18, // 18% of available width
                        height: availableWidth * 0.18, // 18% of available width
                        path: AppColors.getSerebotPath(context),
                        route: AppRoutes.chatbotPage,
                        description:
                            "Talk to our chatbot for support and advice.",
                      ),
                      CardItem(
                        title: "Sere" "Hear",
                        width: availableWidth * 0.16, // 16% of available width
                        height: availableWidth * 0.18, // 18% of available width
                        path: "assets/images/home/menu/serehear.png",
                        route: AppRoutes.musicPage,
                        description: "Listen to calming music for relaxation.",
                      ),
                      CardItem(
                        title: "Sere" "Watch",
                        width: availableWidth * 0.18, // 18% of available width
                        height: availableWidth * 0.18, // 18% of available width
                        path: "assets/images/home/menu/serewatch.png",
                        route: AppRoutes.videoPage,
                        description: "Watch videos that help you relax.",
                      ),
                      CardItem(
                        title: "Sere" "Read",
                        width: availableWidth * 0.16, // 16% of available width
                        height: availableWidth * 0.18, // 18% of available width
                        path: "assets/images/home/menu/sereread.png",
                        route: AppRoutes.bookPage,
                        description: "Read books that bring calm and peace.",
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ), // 2% of screen height for bottom padding
          ],
        ),
      ),
    );
  }
}
