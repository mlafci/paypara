import 'package:paypara/core/base/model/base_model.dart';

class Group extends IBaseModel {
  Group({
    this.result,
    this.error,
    this.isSuccessful,
  });

  Result result;
  dynamic error;
  bool isSuccessful;

  fromJson(Map<String, dynamic> json) => Group(
        result: Result.fromJson(json["result"]),
        error: json["error"],
        isSuccessful: json["isSuccessful"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "error": error,
        "isSuccessful": isSuccessful,
      };
}

class Result {
  Result({
    this.name,
    this.currencyType,
    this.image,
    this.users,
    this.adminUserId,
    this.isActive,
  });

  String name;
  int currencyType;
  String image;
  List<String> users;
  String adminUserId;
  bool isActive;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        currencyType: json["currencyType"],
        image: json["image"],
        users: List<String>.from(json["users"].map((x) => x)),
        adminUserId: json["adminUserId"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "currencyType": currencyType,
        "image": image,
        "users": List<dynamic>.from(users.map((x) => x)),
        "adminUserId": adminUserId,
        "isActive": isActive,
      };
}
