import 'package:flutter/material.dart';
import './index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Fluent Emoji',
      theme: ThemeData.light(),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.count(
          crossAxisCount: 5,
          children: const [
            FluentEmoji(FluentEmojiData.smilingFace),
            FluentEmoji(FluentEmojiData.smilingFaceWithHearts),
            FluentEmoji(FluentEmojiData.faceBlowingAKiss),
            FluentEmoji(FluentEmojiData.faceWithMonocle),
            FluentEmoji(FluentEmojiData.faceWithMonocle),
            FluentEmoji(FluentEmojiData.faceInClouds),
            FluentEmoji(FluentEmojiData.cryingFace),
            FluentEmoji(FluentEmojiData.smilingFaceWithSunglasses),
            FluentEmoji(FluentEmojiData.thinkingFace),
            FluentEmoji(FluentEmojiData.meltingFace),
          ],
        ),
      ),
    );
  }
}
