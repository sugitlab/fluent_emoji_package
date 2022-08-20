import 'package:flutter/material.dart';
import 'tone.dart';
import 'emoji_data.dart';

class FluentEmoji extends StatelessWidget {
  const FluentEmoji(
    this.emoji, {
    Key? key,
    this.size,
    this.network,
  }) : super(key: key);

  // emoji data
  final EmojiData emoji;
  // squared size
  final double? size;
  // get emoji data via network (Github user content)
  final bool? network;

  static const double defaultSize = 50;
  static const String basePath = 'fluent_emoji/assets/';

  @override
  Widget build(BuildContext context) {
    final double emojiSize = size ?? defaultSize;

    Widget emojiImage() {
      if (network ?? false) {
        return Image.network(
          "https://raw.githubusercontent.com/microsoft/fluentui-emoji/main/assets/${emoji.name}/3D/${emoji.file}",
          height: emojiSize,
          width: emojiSize,
        );
      } else {
        return Image.asset(
          "${basePath + emoji.name}/3D/${emoji.file}",
          height: emojiSize,
          width: emojiSize,
        );
      }
    }

    return Semantics(
      child: ExcludeSemantics(
        child: emojiImage(),
      ),
    );
  }
}
