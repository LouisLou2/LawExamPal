class QuesSearchRes{
  String ques;
  String idea;
  String ans;
  QuesSearchRes({
    required this.ques,
    required this.idea,
    required this.ans
  });

  QuesSearchRes.fromJson(Map<String, dynamic> json):
    ques = json['ques'],
    idea = json['idea'],
    ans = json['ans'];

  bool get isValid{
    return ques.isNotEmpty && (idea.isNotEmpty|| ans.isNotEmpty);// 问题必须有，答案或者思路至少有一个
  }
}