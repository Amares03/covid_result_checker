// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.fullName,
    this.passportNum,
    this.dbo,
    this.nationality,
    this.phone,
    this.result,
    this.resultDate,
    this.reviewedBy,
    this.sex,
  });

  String? fullName;
  String? passportNum;
  String? dbo;
  String? nationality;
  String? phone;
  String? result;
  String? resultDate;
  String? reviewedBy;
  String? sex;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fullName: json["fullName"],
        passportNum: json["passportNum"],
        dbo: json["dbo"],
        nationality: json["nationality"],
        phone: json["phone"],
        result: json["result"],
        resultDate: json["resultDate"],
        reviewedBy: json["reviewedBy"],
        sex: json["sex"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "passportNum": passportNum,
        "dbo": dbo,
        "nationality": nationality,
        "phone": phone,
        "result": result,
        "resultDate": resultDate,
        "reviewedBy": reviewedBy,
        "sex": sex,
      };
}
