import 'package:gaurds_game/data/gemini_ai.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/data/model/prompt_response.dart';
import 'package:gaurds_game/locator.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class MainRepository {
  MainRepository({required this.levelNumber});
  final int levelNumber;
  late GeminiAI _geminiAI;

  void initModel() {
    _geminiAI = getIt.get<GeminiAI>(
        param1: Content.system(levels[levelNumber]?.systemInstructions ?? ""));

    print(
        'initModel with system instructions: ${levels[levelNumber]?.systemInstructions}');
  }

  Future<PromptResponse> sendPrompt(String userText) async {
    return await _geminiAI.sendPrompt(userText);
  }
}
