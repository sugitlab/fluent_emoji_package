enum Tone {
  dark,
  defaultTone,
  light,
  medium,
  mediumDark,
  mediumLight,
}

extension ToneExt on Tone {
  String get typeName {
    switch (this) {
      case Tone.dark:
        return "Dark";
      case Tone.defaultTone:
        return "Default";
      case Tone.light:
        return "Light";
      case Tone.medium:
        return "Medium";
      case Tone.mediumDark:
        return "Medium-Dark";
      case Tone.mediumLight:
        return "Medium-Light";
      default:
        return "Default";
    }
  }
}
