import 'package:flutter/material.dart';

import '../../../widgets/main/drawer_menu_widget.dart';
import '../../../utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
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
      body: const Center(
        child: Text(
          "Home Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
