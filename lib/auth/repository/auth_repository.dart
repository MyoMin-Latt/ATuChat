import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/auth/domain/user_model.dart';

class AuthRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  AuthRepository({required this.firestore, required this.auth});

  Future<void> registerUser(UserModel userModel) async {
    await firestore
        .collection('org')
        .doc(userModel.org)
        .collection('users')
        .doc(userModel.userId)
        .set(
          userModel.toMap(),
        );
  }
}
