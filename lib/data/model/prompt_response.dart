import 'guard_mood.dart';

class PromptResponse {
  GuardMood guardMood;
  String response;

  PromptResponse({
    required this.guardMood,
    required this.response,
  });

  // fromJson method
  factory PromptResponse.fromJson(Map<String, dynamic> json) {
    return PromptResponse(
      guardMood: GuardMood.values
          .firstWhere((e) => e.name.toUpperCase() == json['guard_emotions']),
      response: json['response'] as String,
    );
  }
}
