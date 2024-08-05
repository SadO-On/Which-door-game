class QuizQuestion {
  String response;
  List<Option> options;

  QuizQuestion({
    required this.response,
    required this.options,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      response: json['response'] as String,
      options: (json['options'] as List<dynamic>)
          .map((item) => Option.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response': response,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }
}

class Option {
  String value;
  bool isCorrect;

  Option({
    required this.value,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      value: json['value'] as String,
      isCorrect: json['isCorrect'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'isCorrect': isCorrect,
    };
  }
}
