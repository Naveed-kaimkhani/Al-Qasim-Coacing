import 'package:get/get.dart';
import '../../core/network/api_client.dart';
import '../../data/repositories/qr_repository_impl.dart';
import '../../data/services/qr_api_service.dart';
import '../../domain/repositories/qr_repository.dart';
import '../../presentation/viewmodels/qr_viewmodel.dart';

class QrBinding extends Bindings {
  @override
  void dependencies() {
    // API client
    Get.lazyPut(() => ApiClient());

    // API service
    Get.lazyPut(() => QrApiService(Get.find()));

    // Repository: bind abstract type to implementation
    Get.lazyPut<QrRepository>(() => QrRepositoryImpl(Get.find()));

    // ViewModel depends on QrRepository
    Get.lazyPut(() => QrViewModel(Get.find<QrRepository>()));
  }
}
