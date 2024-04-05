class NewChatParam{
  final String token;
  final String ques;
  final bool fromQues;
  NewChatParam({
    required this.token,
    required this.ques,
    required this.fromQues,
  });
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'ques': ques,
      'fromQues': fromQues,
    };
  }
}