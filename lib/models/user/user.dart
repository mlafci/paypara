import 'package:paypara/core/base/model/base_model.dart';

class User extends IBaseModel {
  User({
    this.result,
    this.error,
    this.isSuccessful,
  });

  List<Result> result;
  dynamic error;
  bool isSuccessful;

  fromJson(Map<String, dynamic> json) => User(
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        error: json["error"],
        isSuccessful: json["isSuccessful"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "error": error,
        "isSuccessful": isSuccessful,
      };
}

class Result {
  Result({
    this.email,
    this.emailConfirmed,
    this.id,
    this.lastPasswordChangedDate,
    this.name,
    this.password,
    this.phoneNumber,
    this.surname,
    this.username,
    this.isActive,
    this.isLocked,
    this.image,
  });

  String email;
  bool emailConfirmed;
  String id;
  DateTime lastPasswordChangedDate;
  String name;
  dynamic password;
  dynamic phoneNumber;
  String surname;
  String username;
  bool isActive;
  bool isLocked;
  String image;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        email: json["email"],
        emailConfirmed: json["emailConfirmed"],
        id: json["id"],
        lastPasswordChangedDate: DateTime.parse(json["lastPasswordChangedDate"]),
        name: json["name"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        surname: json["surname"],
        username: json["username"],
        isActive: json["isActive"],
        isLocked: json["isLocked"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "emailConfirmed": emailConfirmed,
        "id": id,
        "lastPasswordChangedDate": lastPasswordChangedDate.toIso8601String(),
        "name": name,
        "password": password,
        "phoneNumber": phoneNumber,
        "surname": surname,
        "username": username,
        "isActive": isActive,
        "isLocked": isLocked,
        "image": image,
      };
}
