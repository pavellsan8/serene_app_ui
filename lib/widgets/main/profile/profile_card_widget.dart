import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/colors.dart';

class ProfileInfoCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ProfileInfoCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    bool isLogout = title == "Log out";

    return Card(
      color: AppColors.getCardColor(context),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(
            icon,
            color: isLogout ? Colors.red : AppColors.getSubtitleColor(context),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isLogout ? Colors.red : AppColors.getFontColor(context),
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color:
                  isLogout ? Colors.red : AppColors.getSubtitleColor(context),
              fontFamily: 'Montserrat',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}

class ProfileInfoShimmerCardWidget extends StatelessWidget {
  const ProfileInfoShimmerCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade400, width: 0.5),
                bottom: BorderSide(color: Colors.grey.shade400, width: 0.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                children: [
                  // Avatar placeholder
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name placeholder
                      Container(
                        width: 200,
                        height: 24,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      // Email placeholder
                      Container(
                        width: 150,
                        height: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Playlist section header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Container(
              width: 100,
              height: 24,
              color: Colors.white,
            ),
          ),

          // Playlist items
          for (int i = 0; i < 3; i++) _buildShimmerListItem(),
          const SizedBox(height: 20),

          // Others section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: 80,
              height: 24,
              color: Colors.white,
            ),
          ),

          // Other items
          for (int i = 0; i < 2; i++) _buildShimmerListItem(),
        ],
      ),
    );
  }

  Widget _buildShimmerListItem() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Icon placeholder
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title placeholder
              Container(
                width: 140,
                height: 18,
                color: Colors.white,
              ),
              const SizedBox(height: 6),
              // Subtitle placeholder
              Container(
                width: 200,
                height: 14,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
