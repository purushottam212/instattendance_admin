import 'package:get/get.dart';
import 'package:instattendance_admin/models/practical_batch_model.dart';
import 'package:instattendance_admin/service/practical_batch_service.dart';

class PracticalBatchController extends GetxController {
  final PracticalBatchService _practicalBatchService = PracticalBatchService();
  var batchList = List<PracticalBatch>.empty(growable: true).obs;
  var isLoading = false.obs;
  Future<PracticalBatch?> createBatch(PracticalBatch batch) async {
    var prBatch = await _practicalBatchService.createBatch(batch);

    if (prBatch != null) {
      return prBatch;
    }
  }

  Future<List<PracticalBatch>?> getPracticalBatches(
      String className, String divName) async {
    List<PracticalBatch>? btList;

    btList = await _practicalBatchService.getBatches(className, divName);
    if (btList != null) {
      batchList.assignAll(btList);
      return btList;
    }
  }

  Future deleteBatch(int id) async {
    return _practicalBatchService.deleteBatch(id);
  }

  
}
