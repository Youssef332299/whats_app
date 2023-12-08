class UserDataModel {
  String? name;
  String? image;
  String? email;
  String? status;
  bool? isOnline;
  String? userAppToken;
  DateTime? createdAt;
  DateTime? lastSeen;

  UserDataModel(
      {required this.name,
      required this.image,
      required this.userAppToken,
      required this.email,
      required this.createdAt,
      required this.status,
      required this.lastSeen,
      required this.isOnline,
      });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'userAppToken': userAppToken,
      'email': email,
      'createdAt': createdAt,
      'lastSeen': lastSeen,
      'isOnline': isOnline,
      'status': status,
    };
  }
}
