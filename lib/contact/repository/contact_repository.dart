import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/domain/user_model.dart';

class ContactRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  ContactRepository({required this.auth, required this.firestore});

  Stream<List<UserModel>> getContact(String org) {
    return firestore
        .collection('org')
        .doc(org)
        .collection('users')
        .snapshots()
        .map((event) {
      List<UserModel> userList = [];
      for (var element in event.docs) {
        userList.add(UserModel.fromMap(element.data()));
      }
      return userList;
    });
  }
}
