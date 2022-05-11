import 'package:http/http.dart' as http;
import 'dart:convert';
import 'userModel.dart';

var idd = "";
var iddd = "";
var sampleid = "";

class UpdateUser {
  Future<UserModel> updateUser(
    String passportNum,
  ) async {
    final String apiUrl =
        "https://covid-result-tester.herokuapp.com/api/users/${passportNum}";
    final Uri url = Uri.parse(apiUrl);

    final response = await http.put(url, body: {"passportNum": passportNum});
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
