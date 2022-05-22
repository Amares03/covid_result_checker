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
}
