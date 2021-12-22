class Account {
  Account({
    this.result,
  });

  Result result;

  factory Account.fromJson(dynamic json) {
    return Account(
      result: Result.fromJson(json["result"]),
    );
  }
}

class Result {
  Result(
      {this.token,
      this.refreshToken,
      this.userId,
      this.name,
      this.surname,
      this.image});

  String token;
  String refreshToken;
  String userId;
  String name;
  String surname;
  String image;

  factory Result.fromJson(dynamic json) {
    return Result(
        token: json["token"],
        refreshToken: json["refreshToken"],
        userId: json["userId"],
        name: json["name"],
        surname: json["surname"],
        image: json["image"]);
  }
}