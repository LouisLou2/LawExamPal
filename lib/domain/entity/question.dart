// 仅支持单选题和简答题
class Question {
  final bool isChoice; // 是否为单选题
  final int quesId; // 问题id
  final String question;
  final List<String>? options; // 选项
  final int? answerIndex; // 从0开始

  Question({
    required this.quesId,
    required this.question,
    required this.options,
    required this.answerIndex,
    this.isChoice = false,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    bool isCho = json['isChoice'];
    return Question(
      isChoice: isCho,
      question: json['question'],
      quesId: json['quesId'],
      options: isCho? List<String>.from(json['options']) : null,
      answerIndex: isCho ? json['answerIndex'] : null,
    );
  }
}