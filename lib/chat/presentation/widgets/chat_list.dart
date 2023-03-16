import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chat/domain/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/enums/message_enum.dart';
import 'my_message_card.dart';
import 'sender_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({
    super.key,
    required this.receiverUserId,
    required this.isGroupChat,
  });

  final String receiverUserId;
  final bool isGroupChat;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  void onMessageSwipe(
    String message,
    bool isMe,
    MessageEnum messageEnum,
  ) {
    // ref
    //     .read(messageReplyProvider.notifier)
    //     .update((state) => MessageReply(message, isMe, messageEnum));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: messageController,
      itemCount: 3,
      itemBuilder: (context, index) {
        // final messageData = snapshot.data![index];
        final messageData = Message(
          senderId: 'senderId',
          receiverId: 'receiverId',
          text: 'text',
          type: MessageEnum.text,
          timeSent: DateTime.now(),
          messageId: 'messageId',
          isSeen: false,
          repliedMessage: 'repliedMessage',
          repliedTo: 'repliedTo',
          repliedMessageType: MessageEnum.text,
        );
        var timeSent = DateFormat.Hm().format(messageData.timeSent);

        // if (!messageData.isSeen &&
        //     messageData.receiverId == FirebaseAuth.instance.currentUser!.uid) {
        //   ref.read(chatControllerProvider).setChatMessageSeen(
        //         context,
        //         widget.receiverUserId,
        //         messageData.messageId,
        //       );
        // }

        // if (messageData.senderId == FirebaseAuth.instance.currentUser!.uid) {
        if (messageData.senderId == 'senderId') {
          return MyMessageCard(
            message: messageData.text,
            date: timeSent,
            type: messageData.type,
            repliedText: messageData.repliedMessage,
            username: messageData.repliedTo,
            repliedMessageType: messageData.repliedMessageType,
            onLeftSwipe: () => onMessageSwipe(
              messageData.text,
              true,
              messageData.type,
            ),
            isSeen: messageData.isSeen,
          );
        }
        return SenderMessageCard(
          message: messageData.text,
          date: timeSent,
          type: messageData.type,
          username: messageData.repliedTo,
          repliedMessageType: messageData.repliedMessageType,
          onRightSwipe: () => onMessageSwipe(
            messageData.text,
            false,
            messageData.type,
          ),
          repliedText: messageData.repliedMessage,
        );
      },
    );
  }
}


// class ChatList extends ConsumerWidget {
//   const ChatList({Key? key, required this.receiverUserId}) : super(key: key);

//   final String receiverUserId;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return StreamBuilder<List<Message>>(
//         stream: ref.read(chatControllerProvider).chatStream(receiverUserId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Loader();
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               final messageData = snapshot.data![index];
//               var timeSent = DateFormat.Hm().format(messageData.timeSent);
//               if (messageData.senderId ==
//                   FirebaseAuth.instance.currentUser!.uid) {
//                 return MyMessageCard(
//                   message: messageData.text,
//                   date: timeSent,
//                 );
//               }
//               return SenderMessageCard(
//                 message: messages[index]['text'].toString(),
//                 date: messages[index]['time'].toString(),
//               );
//             },
//           );
//         });
//   }
// }
