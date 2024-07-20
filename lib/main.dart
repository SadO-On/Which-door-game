import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaurds_game/chat/chat_screen.dart';
import 'package:gaurds_game/env/env.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'locator.dart';

void main() async {
  // final apiKey = Env.geminiKey;
  // if (apiKey == null) {
  //   print('No \$API_KEY environment variable');
  //   exit(1);
  // }
  // // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
  // final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  // final content = [Content.text('Write a story about a AI and magic')];
  // final response = await model.generateContent(content);
  // print(response.text);

  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
            title: 'Which door?',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const ChatScreen());
      },
    );
  }
}
