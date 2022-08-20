import 'package:flutter/material.dart';

class FluentEmoji extends StatelessWidget {
  const FluentEmoji(this.icon, {Key? key, this.size}) : super(key: key);

  final String icon;
  final double? size;
  static const double defaultSize = 50;

  @override
  Widget build(BuildContext context) {
    final double iconSize = size ?? defaultSize;

    return Semantics(
      child: ExcludeSemantics(
        child: Image.asset(
          icon,
          height: iconSize,
          width: iconSize,
        ),
      ),
    );
  }
}

class FluentEmojiData {
  FluentEmojiData._();

  static const String firstPlaceMedal =
      'fluent_emoji/assets/1st place medal/3D/1st_place_medal_3d.png';
  static const String secondPlaceMedal =
      'fluent_emoji/assets/2nd place medal/3D/2nd_place_medal_3d.png';
  static const String thirdPlaceMedal =
      'fluent_emoji/assets/3rd place medal/3D/3rd_place_medal_3d.png';
  static const String aButtonBloodType =
      'fluent_emoji/assets/A button blood type/3D/a_button_blood_type_3d.png';
  static const String abButtonBloodType =
      'fluent_emoji/assets/Ab button blood type/3D/ab_button_blood_type_3d.png';
}
