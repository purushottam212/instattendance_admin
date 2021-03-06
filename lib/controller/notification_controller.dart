import 'package:get/get.dart';
import 'package:instattendance_admin/models/notification_model.dart';
import 'package:instattendance_admin/service/notification_service.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService = NotificationService();
  var notificationsList = List<Notification>.empty(growable: true).obs;

  Future<Notification?> createNotification(Notification notification) async {
    return await _notificationService.createNotification(notification);
  }

  Future<List<Notification>?> getAllNotification() async {
    var list;

    list = await _notificationService.getAllNotification();
    if (list != null) {
      notificationsList.assignAll(list);
    }
  }

  Future deleteNotification(int id) async {
    return _notificationService.deleteNotification(id);
  }
}
