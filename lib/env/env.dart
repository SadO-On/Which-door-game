import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'GEMINI_API', obfuscate: true)
  static final String geminiKey = _Env.geminiKey;
}
