import 'package:gaurds_game/data/gemini_ai.dart';
import 'package:gaurds_game/data/main_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'env/env.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerFactoryParam<GeminiAI, Content, void>((s, _) =>
      GeminiAI.withApiKey(apiKey: Env.geminiKey, systemInstructions: s));

  getIt.registerFactoryParam<MainRepository, int, int>(
      (i, index) => MainRepository(i, index));
}
