import 'package:flutter/material.dart';
import 'package:flutter_chat_app/auth/domain/user_model.dart';
import 'package:flutter_chat_app/chat/presentation/mobile_layout_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../share/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final orgController = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register & Login')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Form(
            key: fromKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter your username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter your phone';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: orgController,
                  decoration: const InputDecoration(labelText: 'Org'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter your org';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                    onPressed: () {
                      UserModel userModel = UserModel(
                        name: nameController.text.trim(),
                        userId: const Uuid().v4(),
                        org: orgController.text.trim(),
                        profilePic: '',
                        isOnline: false,
                        phoneNumber: phoneController.text,
                        groupId: [],
                      );
                      if (fromKey.currentState!.validate()) {
                        ref
                            .read(userProvider.notifier)
                            .update((state) => userModel);
                        ref
                            .read(authRepositoryProvider)
                            .registerUser(userModel)
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MobileLayoutScreen(),
                                )));
                      }
                    },
                    child: const Text('Register'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
