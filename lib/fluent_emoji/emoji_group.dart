enum EmojiGroup {
  activities,
  symbols,
  objects,
  flags,
  foodDrink,
  travelPlaces,
  smileysEmotion,
  peopleBody,
  animalsNature,
}

extension EmojiGroupEx on EmojiGroup {
  String get typeName {
    switch (this) {
      case EmojiGroup.activities:
        return "Activities";
      case EmojiGroup.symbols:
        return "Symbols";
      default:
        return "Activities";
    }
  }
}
