import 'dart:convert';
import 'dart:typed_data';

class User {
  List<UserItem> userItem;
  User({
    this.userItem,
  });

  factory User.fromJson(dynamic json) {
    var list = json["result"] as List;
    List<UserItem> userItem = list.map((i) => UserItem.fromJson(i)).toList();
    return User(
      userItem: userItem,
    );
  }
}

class UserItem {
  String id;
  String email;
  String name;
  String userName;
  Uint8List image;
  UserItem({
    this.id,
    this.email,
    this.name,
    this.userName,
    this.image,
  });
  factory UserItem.fromJson(Map<String, dynamic> json) {
    return UserItem(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      userName: json['userName'],
      image: base64Decode(json['image']),
    );
  }
}
