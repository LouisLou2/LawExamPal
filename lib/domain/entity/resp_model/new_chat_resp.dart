class NewChatResp{
  final int chatId;
  final String title;
  final String ans;
  NewChatResp({
    required this.chatId,
    required this.title,
    required this.ans,
  });
  factory NewChatResp.fromJson(Map<String, dynamic> json) {
    return NewChatResp(
      chatId: json['chatId'],
      title: json['title'],
      ans: json['ans'],
    );
  }
}