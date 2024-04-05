class QuesRecommendParam{
  String token;
  int? quesId;
  String? ques;
  QuesRecommendParam({
    required this.token,
    this.quesId,
    this.ques
  });
  Map<String, dynamic> toJson(){
    // 这里不再assert了，在外面的逻辑中已经做了
    if(quesId!=null){
      return {
        'token': token,
        'quesId': quesId
      };
    }else{
      return {
        'token': token,
        'ques': ques
      };
    }
  }
}