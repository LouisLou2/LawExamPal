class BasicKnowledge {
  static const List<String>roleList = ['应届毕业生','全职备考社会人员','在职备考社会人员','事业编制人员','其他'];
  static const List<String>goalList = ['国考','省考','同时','其他'];

  //保证不少于三个
  static const List<String>typicalPoints = [
    '分总结构',
    '关键词法',
    '类比推理',
  ];

  static String getRole(int index){
    return roleList[index];
  }
  static String getGoal(int index){
    return goalList[index];
  }
  static int getRoleIndex(String role){
    return roleList.indexOf(role);
  }
  static int getGoalIndex(String goal){
    return goalList.indexOf(goal);
  }
}