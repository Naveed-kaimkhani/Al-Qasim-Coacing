import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../models/qr_scan_model.dart';

class QrApiService {
  final ApiClient _client;

  QrApiService(this._client);

  Future<void> submitQr(QrScanModel model) async {
    final response = await _client.post(
      ApiConstants.baseUrl + ApiConstants.submitQr,
      model.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to submit QR");
    }
  }
}
