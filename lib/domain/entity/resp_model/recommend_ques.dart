import 'package:easy_cse/domain/entity/resp_model/question.dart';

class RecommendQues {
  String?topic;
  List<Question>quesList;

  RecommendQues({
    this.topic,
    required this.quesList
  });

  RecommendQues.fromJson(Map<String, dynamic> json):
        topic=json['topic'],
        quesList=(json['quesList'] as List)
            .map((e) => Question.fromJson(e))
            .toList();
}