import 'package:gaurds_game/data/gemini_ai.dart';
import 'package:gaurds_game/data/model/prompt_response.dart';
import 'package:gaurds_game/locator.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class MainRepository {
  final GeminiAI _geminiAI = getIt.get<GeminiAI>(param1: Content.system(""));

  Future<PromptResponse> sendPrompt(String userText) async {
    return await _geminiAI.sendPrompt(userText);
  }
}
