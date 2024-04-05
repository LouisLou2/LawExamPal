class QuesSearchIdParam {
  final String token;
  final int quesId;
  QuesSearchIdParam({
    required this.token,
    required this.quesId,
  });
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'quesId': quesId,
    };
  }
}