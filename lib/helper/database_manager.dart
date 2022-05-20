import 'dart:convert';

import 'package:covid_result_checker/helper/user_model.dart';
import 'package:http/http.dart' as http;

class DatabaseManager {
  static Future<void> addNewPatient({required PatientModel patient}) async {
    const String apiUri = "https://covid-result-tester.herokuapp.com/api/users";

    final Uri uri = Uri.parse(apiUri);

    http.Response response = await http.post(
      uri,
      body: {
        'fullName': patient.fullName,
        'passportNum': patient.passportNumber,
        'dbo': patient.dateOfBirth,
        'sex': patient.gender,
        'nationality': patient.nationality,
        'result': patient.result,
        'resultDate': patient.resultTakenDate,
      },
    );

    if (response.statusCode == 200) {
      print('New Patient added!');
    } else {
      print('Something terrible happened');
    }
  }

  static Future<List<PatientModel>> viewAllPatient() async {
    const String apiUri = "https://covid-result-tester.herokuapp.com/api/users";
    final response = await http.get(Uri.parse(apiUri));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body.map<PatientModel>(PatientModel.fromJson).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static updateUser({required PatientModel patient}) async {
    final String apiUrl =
        "https://covid-result-tester.herokuapp.com/api/users/${patient.passportNumber}";

    final Uri url = Uri.parse(apiUrl);

    final response = await http.put(url, body: {
      'fullName': patient.fullName,
      'passportNum': patient.passportNumber,
      'dbo': patient.dateOfBirth,
      'sex': patient.gender,
      'nationality': patient.nationality,
      'result': patient.result,
      'resultDate': patient.resultTakenDate,
    });
  }

  static deleteUser({required String passNumber}) async {
    final String apiUrl =
        "https://covid-result-tester.herokuapp.com/api/users/$passNumber";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('deleted success');
    } else {
      print(response.statusCode);
    }
  }
}
