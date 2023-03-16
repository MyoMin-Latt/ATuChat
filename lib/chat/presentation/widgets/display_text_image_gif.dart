// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../common/enums/message_enum.dart';

class DisplayTextImageGIF extends StatelessWidget {
  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);
  final String message;
  final MessageEnum type;

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();

    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.audio
            ? StatefulBuilder(builder: (context, setstate) {
                return IconButton(
                  constraints: const BoxConstraints(minWidth: 100),
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                      setstate(() => isPlaying = false);
                    } else {
                      await audioPlayer.play(UrlSource(message));
                      setstate(() => isPlaying = true);
                    }
                  },
                  icon:
                      Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
                );
              })
            : type == MessageEnum.gif
                ? CachedNetworkImage(imageUrl: message)
                : CachedNetworkImage(imageUrl: message);
  }
}
