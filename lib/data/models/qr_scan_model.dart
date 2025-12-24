class QrScanModel {
  final String code;

  QrScanModel({required this.code});

  Map<String, dynamic> toJson() {
    return {
      "qr_code": code,
    };
  }
}
