import 'guardMood.dart';

class PromptResponse {
  String mission;
  GuardMood guardMood;
  String response;

  PromptResponse({
    required this.mission,
    required this.guardMood,
    required this.response,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'mission': mission,
      'guardMood': guardMood.toString().split('.').last,
      'response': response,
    };
  }

  // fromJson method
  factory PromptResponse.fromJson(Map<String, dynamic> json) {
    return PromptResponse(
      mission: json['mission'],
      guardMood: GuardMood.values
          .firstWhere((e) => e.toString().split('.').last == json['guardMood']),
      response: json['response'],
    );
  }
}
