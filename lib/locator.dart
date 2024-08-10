import 'package:gaurds_game/data/gemini_ai.dart';
import 'package:gaurds_game/data/main_repository.dart';
import 'package:gaurds_game/data/storage_repository.dart';
import 'package:gaurds_game/level/level_store.dart';
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/sp.dart';
import 'env/env.dart';

final getIt = GetIt.instance;

Future setupGetIt() async {
  getIt.registerFactoryParam<GeminiAI, Content, void>((s, _) =>
      GeminiAI.withApiKey(apiKey: Env.geminiKey, systemInstructions: s));

  getIt.registerFactoryParam<MainRepository, int, int>(
      (i, index) => MainRepository(i, index));

  getIt.registerSingletonAsync<SP>(() async {
    final pref = await SharedPreferences.getInstance();
    return SP(pref: pref);
  });

  await getIt.isReady<SP>();

  getIt.registerSingleton<StorageRepository>(StorageRepository());

  getIt.registerSingleton<LevelStore>(LevelStore());
}
