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
  Result({
    this.token,
    this.refreshToken,
    this.userId,
    this.userName,
    this.claims,
    this.image,
  });

  String token;
  String refreshToken;
  String userId;
  String userName;
  String image;
  List<Claims> claims;

  factory Result.fromJson(dynamic json) {
    var list = json['claims'] as List;
    List<Claims> claims = list.map((i) => Claims.fromJson(i)).toList();
    return Result(
      token: json["token"],
      refreshToken: json["refreshToken"],
      userId: json["userId"],
      userName: json["userName"],
      image: json["image"],
      claims: claims,
    );
  }
}

class Claims {
  Claims({
    this.name,
  });
  String name;

  factory Claims.fromJson(Map<String, dynamic> json) => Claims(
        name: json["name"],
      );
}