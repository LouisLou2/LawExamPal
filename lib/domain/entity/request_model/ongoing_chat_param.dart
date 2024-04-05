class OngoingChatParam {
  final String token;
  final int chatId;
  final String ques;

  OngoingChatParam({
    required this.token,
    required this.chatId,
    required this.ques,
  });
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'chatId': chatId,
      'ques': ques,
    };
  }
}