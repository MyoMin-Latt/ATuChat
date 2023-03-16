import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chat/domain/chat_contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatUserList extends ConsumerStatefulWidget {
  const ChatUserList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatUserListState();
}

class _ChatUserListState extends ConsumerState<ChatUserList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        // var chatContactData = snapshot.data![index];
        var chatContactData = ChatContact(
            name: 'name',
            profilePic: 'profilePic',
            contactId: 'contactId',
            timeSent: DateTime.now(),
            lastMessage: 'lastMessage');
        return Column(
          children: [
            InkWell(
              onTap: () {
                // Navigator.pushNamed(context, MobileChatScreen.routeName,
                //     arguments: {
                //       'name': chatContactData.name,
                //       'uid': chatContactData.contactId,
                //       'isGroupChat': false,
                //     });
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  title: Text(
                    chatContactData.name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      chatContactData.lastMessage,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      chatContactData.profilePic,
                    ),
                    radius: 30,
                  ),
                  trailing: Text(
                    DateFormat.Hm().format(chatContactData.timeSent),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(color: Colors.grey, indent: 85),
          ],
        );
      },
    );
  }
}
