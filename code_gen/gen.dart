import 'dart:io';
import 'dart:convert';

void main() {
  loadMeta(
    "${Directory.current.path}/fluent_emoji/assets/",
  );
}

String specialConverter(String name) {
  List<String> words = name.split(RegExp(r'[ _\-]'));
  String result = words[0].toLowerCase();
  for (var i = 1; i < words.length; i++) {
    result = result + words[i][0].toUpperCase() + words[i].substring(1);
  }
  // Special Conversion
  result = result.replaceAll("1st", "first");
  result = result.replaceAll("2nd", "second");
  result = result.replaceAll("3rd", "third");
  result = result.replaceAll("!", "");
  result = result.replaceAll("piñata", "pinata");

  return result;
}

String getEmojiDataString(
  String defName,
  String name,
  String file,
  List<String> keywords,
  String group, {
  String? tone,
}) {
  if (tone == null) {
    return """
  static const EmojiData $defName = EmojiData(
    "$name",
    "$file",
    keywords: ${keywords.toString()},
    group: EmojiGroup.${specialConverter(group).replaceAll("&", "")},
  );
  """;
  } else {
    return """
  static const EmojiData $defName = EmojiData(
    "$name",
    "$file",
    keywords: ${keywords.toString()},
    group: EmojiGroup.${specialConverter(group).replaceAll("&", "")},
    tone: Tone.${(tone == "default") ? "${tone}Tone" : tone},
  );
  """;
  }
}

// [HACK] Exclude emojis which doesn't have 3D png image
List<String> excludeList = [
  "Heavy dollar sign", // No png, only svg
  "Mans shoe", // No png, only svg
];

Future<void> loadMeta(String path) async {
  final emojiNames = await Directory(path)
      .list()
      .map((item) => item.path.split('/').last)
      .toList();
  emojiNames.sort();
  emojiNames.removeWhere(
    // Remove hidden directories
    (el) => el.startsWith("."),
  );

  final List<String> pubspecList = [];
  String emojiDefs = """
import './emoji_group.dart';
import './emoji_data.dart';
import './tone.dart';

class FluentEmojiData {
  """;
  for (var i = 0; i < emojiNames.length; i++) {
    if (excludeList.contains(emojiNames[i])) {
      continue;
    }
    String content = await File("$path/${emojiNames[i]}/metadata.json")
        .readAsString(encoding: utf8);
    final data = jsonDecode(content);
    String group = data["group"];
    List<dynamic> jsonKeywords = data["keywords"];
    List<String> keywords = jsonKeywords.map((el) => '"$el"').toList();

    final tones = await Directory("$path/${emojiNames[i]}")
        .list()
        .map((item) => item.path.split('/').last)
        .toList();
    if (tones.contains("Dark")) {
      for (var el in [
        "Dark",
        "Default",
        "Light",
        "Medium",
        "Medium-Dark",
        "Medium-Light"
      ]) {
        // [HACK] No 3D image
        if (emojiNames[i] == "Pregnant person" && el == "Medium-Dark") {
          continue;
        }

        final file =
            "${emojiNames[i].toLowerCase().replaceAll(" ", "_")}_3d_${el.toLowerCase()}.png";

        pubspecList.add("fluent_emoji/assets/${emojiNames[i]}/$el/3D/$file");

        emojiDefs = emojiDefs +
            getEmojiDataString(
              "${specialConverter(emojiNames[i])}${el.replaceAll("-", "")}",
              "${emojiNames[i]}/$el",
              file,
              keywords,
              group,
              tone: specialConverter(el),
            );
      }
    } else {
      String file =
          "${emojiNames[i].toLowerCase().replaceAll(" ", "_")}_3d.png";

      // [HACK] Pattern broken file name.
      if (emojiNames[i] == "O button blood type") {
        file = "o_button_(blood_type)_3d.png";
      }

      pubspecList.add("fluent_emoji/assets/${emojiNames[i]}/3D/$file");
      emojiDefs = emojiDefs +
          getEmojiDataString(
            specialConverter(emojiNames[i]),
            emojiNames[i],
            file,
            keywords,
            group,
          );
    }
  }

  // For fluent_emoji_data
  emojiDefs = "$emojiDefs}";
  File('lib/fluent_emoji/fluent_emoji_data.dart').writeAsString(emojiDefs);

  // For pubspec.yaml
  File('fluent_assets.yaml')
      .writeAsString(pubspecList.map((el) => "- \"$el\"").join('\n'));
}
