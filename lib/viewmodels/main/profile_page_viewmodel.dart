import 'package:flutter/material.dart';
import '../../models/main/profile_page_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileModel _profile = ProfileModel(
    name: "Alexander Graham",
    email: "alex.graham@gmail.com",
    dateOfBirth: "24 September 1999",
    phoneNumber: "+62 456-789-1012",
    profileImageUrl: "https://via.placeholder.com/150",
    moods: ["Peaceful", "Pessimistic", "Joyful", "Sad", "Overwhelmed"],
  );

  ProfileModel get profile => _profile;
}
