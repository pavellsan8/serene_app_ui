class ProfileModel {
  final String name;
  final String email;
  final String dateOfBirth;
  final String phoneNumber;
  final String profileImageUrl;
  final List<String> moods;

  ProfileModel({
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.moods,
  });
}
