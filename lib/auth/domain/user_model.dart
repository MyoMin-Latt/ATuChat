// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String userId;
  final String org;
  final String profilePic;
  final bool isOnline;
  final String phoneNumber;
  final List<dynamic> groupId;
  UserModel({
    required this.name,
    required this.userId,
    required this.org,
    required this.profilePic,
    required this.isOnline,
    required this.phoneNumber,
    required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': userId,
      'org': org,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      userId: map['uid'] ?? '',
      org: map['org'] ?? '',
      profilePic: map['profilePic'] ?? '',
      isOnline: map['isOnline'] ?? false,
      phoneNumber: map['phoneNumber'] ?? '',
      groupId: List<dynamic>.from(map['groupId']),
    );
  }
}
