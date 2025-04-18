import 'package:flutter/material.dart';

class TeamMemberWidget extends StatelessWidget {
  final String image;
  final String name;
  final String role;

  const TeamMemberWidget({
    super.key,
    required this.image,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            image,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          role,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontFamily: 'Montserrat',
          ),
        ),
      ],
    );
  }
}
