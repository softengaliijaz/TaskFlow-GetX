import 'package:get/get.dart';
import 'package:taskflow_getx/controllers/counter_controller.dart';

class CounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CounterController());
  }
}
