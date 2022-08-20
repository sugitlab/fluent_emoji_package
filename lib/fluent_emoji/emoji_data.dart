import './tone.dart';
import './emoji_group.dart';

class EmojiData {
  const EmojiData(this.name, this.file, {this.tone, this.keywords, this.group});
  final String name;
  final String file;
  final Tone? tone;
  final List<String>? keywords;
  final EmojiGroup? group;

  static const String basePath = 'fluent_emoji/assets/';
}
