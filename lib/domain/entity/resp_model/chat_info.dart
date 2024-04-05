class ChatInfo{
  bool _role; // true表示user，false表示model
  String _text;
  ChatInfo(this._role, this._text);
  bool get role => _role;
  String get text => _text;
  set role(bool value) {
    _role = value;
  }
  set text(String value) {
    _text = value;
  }
  factory ChatInfo.fromJson(Map<String, dynamic> json) {
    return ChatInfo(
      json['role'],
      json['text'],
    );
  }
  factory ChatInfo.error() {
    return ChatInfo(false, '🚨Error Getting Answer');
  }
}