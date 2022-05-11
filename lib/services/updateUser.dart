import 'package:http/http.dart' as http;
import 'dart:convert';
import 'userModel.dart';

var idd = "";
var iddd = "";
var sampleid = "";

class UpdateUser {
  Future<UserModel> updateUser(
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
    final String apiUrl =
        "https://covid-result-tester.herokuapp.com/api/users/${passportNum}";
    final Uri url = Uri.parse(apiUrl);

    final response = await http.put(url, body: {
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
      // iddd = jsonDecode(resposeString);
      // idd = jsonDecode(resposeString);
      return userModelFromJson(resposeString);
    } else {
      const String responseString = "not worked";
      return userModelFromJson(responseString);
    }
  }

  Future<UserModel> findUser(
    String passportNum,
  ) async {
    final String apiUrl =
        "https://covid-result-tester.herokuapp.com/api/users/${passportNum}";
    final Uri url = Uri.parse(apiUrl);

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final String resposeString = response.body;

      // ignore: dead_code
      iddd = jsonDecode(resposeString);
      idd = jsonDecode(resposeString);
      return userModelFromJson(resposeString);
    } else {
      const String responseString = "not worked";
      return userModelFromJson(responseString);
    }
  }

  dynamic getUserInfo() {
    return iddd;
  }

  String getSampleId() {
    return sampleid.toString();
  }

  String getId() {
    return idd.toString();
  }
}
