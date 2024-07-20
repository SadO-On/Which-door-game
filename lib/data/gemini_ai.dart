import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';

import 'model/prompt_response.dart';

class GeminiAI {
  GeminiAI(this._generativeModel);

  factory GeminiAI.withApiKey(
          {required String apiKey, required Content systemInstructions}) =>
      GeminiAI(GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: apiKey,
          systemInstruction: systemInstructions));

  final GenerativeModel _generativeModel;

  Future<PromptResponse> sendPrompt(String prompt) async {
    final content = [Content.text(prompt)];
    final response = await _generativeModel.generateContent(content);
    final json = jsonDecode(response.text!) as Map<String, dynamic>;
    final PromptResponse promptResponse = PromptResponse.fromJson(json);
    return promptResponse;
  }
}
