import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class ProfileInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ProfileInfoCard({
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
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(
            icon,
            color: isLogout
                ? Colors.red
                : AppColors.subtitleTextColor,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isLogout
                  ? Colors.red
                  : Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: isLogout
                  ? Colors.red
                  : AppColors
                      .subtitleTextColor,
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
