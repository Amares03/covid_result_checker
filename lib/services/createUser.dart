// ignore_for_file: file_names, prefer_const_declarations

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'userModel.dart';

var idd = "";
var sampleid = "";

class CreateUser {
  Future<UserModel> createUser(
    String fullName,
    String passportNum,
    String dbo,
    String nationality,
    String phone,
    String result,
    String resultDate,
    String reviewedBy,
    String sex,
  ) async {
    final String apiUrl = "https://iclilaboratory.herokuapp.com/api/user";
    final Uri url = Uri.parse(apiUrl);

    final response = await http.post(url, body: {
      "fullName": fullName,
      "passportNum": passportNum,
      "dbo": dbo,
      "nationality": nationality,
      "phone": phone,
      "result": result,
      "resultDate": resultDate,
      "reviewedBy": reviewedBy,
      "sex": sex
    });
    if (response.statusCode == 200) {
      final String resposeString = response.body;

      // ignore: dead_code
      var iddd = jsonDecode(resposeString);
      sampleid = iddd['sampleId'];
      idd = iddd['_id'];
      return userModelFromJson(resposeString);
    } else {
      final String responseString = "not worked";
      return userModelFromJson(responseString);
    }
  }

  String getSampleId() {
    return sampleid.toString();
  }

  String getId() {
    return idd.toString();
  }
}
