class ChatUser {
  ChatUser({
    required this.isOnline,
    required this.id,
    required this.createdAt,
    required this.name,
    required this.image,
    required this.email,
    required this.pushToken,
    required this.about,
    required this.lastActive,
  });
  late final bool isOnline;
  late final String id;
  late final String createdAt;
  late final String name;
  late final String image;
  late final String email;
  late final String pushToken;
  late final String about;
  late final String lastActive;
  ChatUser.fromJson(Map<String, dynamic> json){
    isOnline = json['is_online'] ?? '';
    id = json['id'] ?? '';
    createdAt = json['created_at'] ?? '';
    name = json['name'] ?? '';
    image = json['image'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
    about = json['about'] ?? '';
    lastActive = json['last_active'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['is_online'] = isOnline;
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['name'] = name;
    _data['image'] = image;
    _data['email'] = email;
    _data['push_token'] = pushToken;
    _data['about'] = about;
    _data['last_active'] = lastActive;
    return _data;
  }
}