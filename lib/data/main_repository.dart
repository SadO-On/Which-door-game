import 'package:gaurds_game/data/gemini_ai.dart';
import 'package:gaurds_game/data/model/level.dart';
import 'package:gaurds_game/data/model/prompt_response.dart';
import 'package:gaurds_game/locator.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class MainRepository {
  // MainRepository({required this.levelNumber});
  final int _levelNumber;
  final int guardIndex;
  late GeminiAI _geminiAI;

  MainRepository(this._levelNumber, this.guardIndex) {
    _geminiAI = getIt.get<GeminiAI>(
        param1: Content.system(
            levels[_levelNumber]?.systemInstructions[guardIndex] ?? ""));

    print(
        'initModel with system instructions: ${levels[_levelNumber]?.systemInstructions[guardIndex]}');
  }

  Future<PromptResponse> sendPrompt(String userText) async {
    return await _geminiAI.sendPrompt(userText);
  }
}
