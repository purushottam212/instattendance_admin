import 'package:instattendance_admin/models/practical_batch_model.dart';
import 'package:instattendance_admin/repository/practical_batch_repository.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class PracticalBatchService {
  final PracticalBatchRepository _practicalBatchRepository =
      PracticalBatchRepository();

  Future<PracticalBatch?> createBatch(PracticalBatch batch) async {
    try {
      return await _practicalBatchRepository.createBatch(batch);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }
  }

  Future<List<PracticalBatch>?> getBatches(
      String className, String divName) async {
    try {
      return await _practicalBatchRepository.getBatchesByClassAndDiv(
          className, divName);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }
  }

  Future deleteBatch(int id) async {
    try {
      return await _practicalBatchRepository.deleteBatch(id);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }
  }
}
