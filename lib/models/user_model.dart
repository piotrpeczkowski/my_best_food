class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.userCity,
    required this.userGender,
    required this.imageUrl,
  });

  final String id;
  final String email;
  final String userName;
  final String userCity;
  final String userGender;
  final String imageUrl;
}
