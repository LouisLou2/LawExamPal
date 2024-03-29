class ChatTopic{
  final int id;
  final String name;
  DateTime lastMsgTime; //从时间戳读取

  ChatTopic({
    required this.id,
    required this.name,
    required this.lastMsgTime,
  });
  factory ChatTopic.fromJson(Map<String, dynamic> json) {
    return ChatTopic(
      id: json['id'],
      name: json['name'],
      lastMsgTime: DateTime.fromMillisecondsSinceEpoch(json['lastMsgTime']),
    );
  }
}