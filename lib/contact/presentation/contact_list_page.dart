import 'package:flutter/material.dart';
import 'package:flutter_chat_app/auth/domain/user_model.dart';
import 'package:flutter_chat_app/auth/share/auth_provider.dart';
import 'package:flutter_chat_app/chat/presentation/mobile_chat_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/presentation/widgets/loader.dart';
import '../share/contact_providers.dart';

class ContactListPage extends ConsumerStatefulWidget {
  const ContactListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserListPageState();
}

class _UserListPageState extends ConsumerState<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    final org = ref.watch(userProvider).org;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose User'),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: ref.read(contactRepositoryProvider).getContact(org),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var sortList = snapshot.data!;
                sortList.sort(
                  (a, b) => a.name.compareTo(b.name),
                );
                var user = sortList[index];
                return InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MobileChatScreen(
                        name: user.name, uid: 'uid', isGroupChat: false),
                  )),
                  child: ListTile(
                    leading: CircleAvatar(child: Text((index + 1).toString())),
                    title: Text(user.name),
                    subtitle: Text(user.org),
                  ),
                );
              },
            );
          } else {
            return const Loader();
          }
        },
      ),
    );
  }
}
