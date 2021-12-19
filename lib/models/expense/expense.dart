import 'package:paypara/core/base/model/base_model.dart';

class Expense extends IBaseModel {
  Expense({
    this.result,
    this.error,
    this.isSuccessful,
  });

  List<Result> result;
  dynamic error;
  bool isSuccessful;

  fromJson(Map<String, dynamic> json) => Expense(
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
    this.nameSurname,
    this.categoryId,
    this.price,
    this.date,
    this.note,
  });

  String nameSurname;
  int categoryId;
  int price;
  DateTime date;
  String note;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        nameSurname: json["nameSurname"],
        categoryId: json["categoryId"],
        price: json["price"],
        date: DateTime.parse(json["date"]),
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "nameSurname": nameSurname,
        "categoryId": categoryId,
        "price": price,
        "date": date.toIso8601String(),
        "note": note,
      };
}