import 'package:google_generative_ai/google_generative_ai.dart';

import '../locator.dart';
import 'gemini_ai.dart';
import 'model/level.dart';
import 'model/prompt_response.dart';

class MainRepository {
  final int _levelNumber;
  final int guardIndex;
  late GeminiAI _geminiAI;

  MainRepository(this._levelNumber, this.guardIndex) {
    _geminiAI = getIt.get<GeminiAI>(
        param1: Content.system(
            levels[_levelNumber]?.systemInstructions[guardIndex] ?? ""));
  }

  Future<PromptResponse> sendPrompt(String userText) async {
    try {
      return await _geminiAI.sendPrompt(userText);
    } catch (e) {
      rethrow;
    }
  }
}
