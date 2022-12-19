class QuestionBody {
  String question;
  List<String> answers;
  int? correctAnswerIndex;

  QuestionBody({
    this.question = "",
    required this.answers,
    this.correctAnswerIndex,
  });

  void copyWith({
    String? question,
    List<String>? answers,
    int? correctAnswerIndex,
  }) {
    this.question = question ?? this.question;
    this.answers = answers ?? this.answers;
    this.correctAnswerIndex = correctAnswerIndex ?? this.correctAnswerIndex;
  }

  Map<String, dynamic> toJson() {
    return {
      "answers": answers,
      "question": question,
      "correct_answer": correctAnswerIndex,
    };
  }
}
