class AppFeature{
  final String title;
  final String desc;
  const AppFeature(this.title,this.desc);
}
class AppProperties{
  static const String appName = "EasyCSE";
  static const String appVersion = "1.0.0";
  static const List<AppFeature>features = [
    AppFeature(
      "精品题库",
      "智能考公助手拥有精心筛选的题库，涵盖各种考试所需的核心知识点和题型，帮助你高效备考",
    ),
    AppFeature(
      "AI助手",
      "AI助手能够根据用户的学习情况和需求，提供个性化的学习推荐和解题策略，提升学习效率",
    ),
    AppFeature(
      "智能笔记",
      "轻松记录重点知识、做题经验等内容，智能整理并提供复习提醒，帮助你更好地巩固学习成果",
    ),
  ];
}