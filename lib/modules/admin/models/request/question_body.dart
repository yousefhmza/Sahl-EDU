class QuestionBody {
  String question;
  List<String> answers;
  int correctAnswerIndex;

  QuestionBody({
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
  });

  Map<String, dynamic> toJson() {
    return {};
  }
}
