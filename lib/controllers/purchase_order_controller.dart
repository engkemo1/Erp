import 'package:get/get.dart';


class PurchaseOrderController extends GetxController {
  bool isExpanded = false;


  changeValue(bool value) {
    isExpanded = value;
    update();
  }
}
