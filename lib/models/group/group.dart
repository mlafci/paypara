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
    this.groupDetails,
    this.totalExpense,
  });

  List<GroupDetail> groupDetails;
  int totalExpense;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        groupDetails: List<GroupDetail>.from(
            json["groupDetails"].map((x) => GroupDetail.fromJson(x))),
        totalExpense: json["totalExpense"],
      );

  Map<String, dynamic> toJson() => {
        "groupDetails": List<dynamic>.from(groupDetails.map((x) => x.toJson())),
        "totalExpense": totalExpense,
      };
}

class GroupDetail {
  GroupDetail({
    this.id,
    this.name,
    this.currencyType,
    this.groupImage,
    this.priceStatus,
  });

  int id;
  String name;
  int currencyType;
  String groupImage;
  int priceStatus;

  factory GroupDetail.fromJson(Map<String, dynamic> json) => GroupDetail(
        id: json["id"],
        name: json["name"],
        currencyType: json["currencyType"],
        groupImage: json["groupImage"] == null ? null : json["groupImage"],
        priceStatus: json["priceStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "currencyType": currencyType,
        "groupImage": groupImage == null ? null : groupImage,
        "priceStatus": priceStatus,
      };
}