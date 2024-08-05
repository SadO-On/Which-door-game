import 'dart:convert';

import 'package:gaurds_game/data/model/system_instructions.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'model/math_problem.dart';
import 'model/prompt_response.dart';

class GeminiAI {
  GeminiAI(this._generativeModel);

  factory GeminiAI.withApiKey(
          {required String apiKey, required Content systemInstructions}) =>
      GeminiAI(GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: apiKey,
          safetySettings: _safetySettings,
          generationConfig: GenerationConfig(
            temperature: 2,
          ),
          systemInstruction: systemInstructions));

  final GenerativeModel _generativeModel;

  Future<PromptResponse> sendPrompt(String prompt) async {
    final content = [Content.text(prompt)];
    final response = await _generativeModel.generateContent(content);
    final textValue = response.text.toString().replaceAll('\n', '\\n');
    final json = jsonDecode(textValue) as Map<String, dynamic>;
    final PromptResponse promptResponse = PromptResponse.fromJson(json);
    return promptResponse;
  }

  Future<QuizQuestion> getQuizQuestion() async {
    final content = [Content.text(mathPrompt)];
    final response = await _generativeModel.generateContent(content);
    final textValue =
        response.text.toString().replaceAll('json', '').replaceAll('`', '');

    print(textValue);
    final json = jsonDecode(textValue) as Map<String, dynamic>;
    final QuizQuestion quizQuestion = QuizQuestion.fromJson(json);
    return quizQuestion;
  }
}

List<SafetySetting> _safetySettings = [
  SafetySetting(
    HarmCategory.harassment,
    HarmBlockThreshold.none,
  ),
  SafetySetting(
    HarmCategory.hateSpeech,
    HarmBlockThreshold.none,
  ),
  SafetySetting(
    HarmCategory.sexuallyExplicit,
    HarmBlockThreshold.high,
  ),
  SafetySetting(
    HarmCategory.dangerousContent,
    HarmBlockThreshold.none,
  ),
];
