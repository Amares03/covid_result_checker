import 'dart:convert';

import 'constants.dart';
import 'user_model.dart';
import 'package:http/http.dart' as http;

enum OperationStatus {
  updateSuccess,
  updateFailed,
  deleteSuccess,
  deleteFailed,
  createSuccess,
  createFailed,
}

class DatabaseManager {
  static Future<OperationStatus> addNewPatient({required PatientModel patient}) async {
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
      return OperationStatus.createSuccess;
    } else {
      return OperationStatus.createFailed;
    }
  }

  static Future<List<PatientModel>> viewAllPatient() async {
    final response = await http.get(Uri.parse(apiUri));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body.map<PatientModel>(PatientModel.fromJson).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future getSinglePatientModel({required String id}) async {
    final response = await http.get(Uri.parse('$apiUri$id'));

    if (response.statusCode == 200) {
      final patient = PatientModel.fromJson(json.decode(response.body));
      return patient;
    } else {
      return '';
    }
  }

  static Future<OperationStatus> updateUser({required PatientModel patient}) async {
    final Uri url = Uri.parse('$apiUri${patient.passportNumber}');

    final response = await http.put(
      url,
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
      return OperationStatus.updateSuccess;
    } else {
      return OperationStatus.updateFailed;
    }
  }
}
