import 'package:instattendance_admin/widget/show_toast.dart';

class RepositoryConstants {
  static const int statusSuccessful = 200;
  static const int internalServerError = 500;
  static const int badRequest = 400;
  static const int timeout = 408;
  static const String baseUrl = 'http://192.168.1.4:8080';

  static validateErrorCodes(int statusCode) {
    if (statusCode == RepositoryConstants.timeout) {
      DisplayMessage.showMsg('Request Time Out ..check your connection');
    }
    if (statusCode == RepositoryConstants.internalServerError) {
      DisplayMessage.showMsg('Internal Server Error');
    }
  }
}
