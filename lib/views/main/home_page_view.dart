import 'package:flutter/material.dart';

import '../../widgets/main/drawer_menu_widget.dart';
import '../../utils/colors.dart';
import '../../utils/routes.dart';
import '../../widgets/main/card_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: const DrawerMenu(),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Image.asset(
                'assets/images/logo.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Our Service",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Mmontserrat',
                  ),
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
                childAspectRatio: 0.8,
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

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50); // Mulai dari kiri bawah

    // Membuat lengkungan dari kiri ke kanan
    path.lineTo(0, size.height * 0.9); // Mulai turun dari kiri

    path.quadraticBezierTo(
      size.width * 0.5, size.height * 1.1, // Titik tengah (puncak naik)
      size.width, size.height * 0.9, // Kembali ke kanan
    );

    path.lineTo(size.width, 0); // Tutup ke kanan atas
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
