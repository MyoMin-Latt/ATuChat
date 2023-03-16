import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/auth/domain/user_model.dart';
import 'package:flutter_chat_app/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance),
);

final userProvider = StateProvider<UserModel>(
  (ref) => UserModel(
    name: '',
    userId: '',
    org: '',
    profilePic: '',
    isOnline: false,
    phoneNumber: '',
    groupId: [],
  ),
);
