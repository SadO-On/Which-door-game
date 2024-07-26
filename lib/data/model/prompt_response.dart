import 'guardMood.dart';

class PromptResponse {
  // GuardMood guardMood;
  String response;

  PromptResponse({
    // required this.guardMood,
    required this.response,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      // 'guardMood': guardMood.toString().split('.').last,
      'response': response,
    };
  }

  // fromJson method
  factory PromptResponse.fromJson(Map<String, dynamic> json) {
    return PromptResponse(
      // guardMood: GuardMood.values
      //     .firstWhere((e) => e.toString().split('.').last == json['guardMood']),
      response: json['response'] as String,
    );
  }
}
