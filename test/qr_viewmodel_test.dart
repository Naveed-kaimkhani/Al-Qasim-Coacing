import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_code_scanner/presentation/viewmodels/qr_viewmodel.dart';
import 'mocks/mock_qr_repository.dart';
void main() {
  late MockQrRepository repository;
  late QrViewModel viewModel;

  setUp(() {
    repository = MockQrRepository();
    viewModel = QrViewModel(repository);
  });

  test("Should emit success when QR submission succeeds", () async {
    when(() => repository.submitQr(any()))
        .thenAnswer((_) async {});

    await viewModel.processQr("VALID_QR_CODE");

    expect(viewModel.status.value, QrStatus.success);
  });

  test("Should emit error for invalid QR", () async {
    await viewModel.processQr("");

    expect(viewModel.status.value, QrStatus.error);
  });
}
