// 仅支持单选题和简答题
class Question {
  final bool isChoice; // 是否为单选题
  final int quesId; // 问题id
  final String ques;
  final List<String>? options; // 选项
  final int? ans; // 从0开始

  Question({
    required this.quesId,
    required this.ques,
    required this.options,
    required this.ans,
    this.isChoice = false,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    bool isCho = json['isChoice'];
    return Question(
      isChoice: isCho,
      ques: json['ques'],
      quesId: json['quesId'],
      options: isCho? List<String>.from(json['options']) : null,
      ans: isCho ? json['ans'] : null,
    );
  }
}