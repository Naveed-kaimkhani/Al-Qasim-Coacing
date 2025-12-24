import '../../domain/repositories/qr_repository.dart';
import '../models/qr_scan_model.dart';
import '../services/qr_api_service.dart';

class QrRepositoryImpl implements QrRepository {
  final QrApiService _service;

  QrRepositoryImpl(this._service);

  @override
  Future<void> submitQr(String code) async {
    final model = QrScanModel(code: code);
    await _service.submitQr(model);
  }
}
