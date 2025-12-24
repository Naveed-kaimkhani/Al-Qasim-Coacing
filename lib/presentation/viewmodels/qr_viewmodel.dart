import 'package:get/get.dart';
import '../../domain/repositories/qr_repository.dart';
import '../../core/utils/validators.dart';
enum QrStatus { idle, loading, success, error }

class QrViewModel extends GetxController {
  final QrRepository repository;

  QrViewModel(this.repository);

  final status = QrStatus.idle.obs;
  final message = ''.obs;

  Future<void> processQr(String code) async {
    if (!Validators.isValidQr(code)) {
      status.value = QrStatus.error;
      message.value = "Invalid QR Code";
      return;
    }

    try {
      status.value = QrStatus.loading;
      await repository.submitQr(code);
      status.value = QrStatus.success;
      message.value = "QR submitted successfully";
    } catch (e) {
      status.value = QrStatus.error;
      message.value = "Submission failed";
    }
  }
}
