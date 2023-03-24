import 'dart:io';

import 'package:get/get.dart';

import '../utils/constants.dart';

class SettingController extends GetxController {
  var swithchValue = false.obs;

  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        swithchValue.value=true;
        connected = true;
        update();
      }
    } on SocketException catch (_) {
      swithchValue.value=false;

      connected = false;      update();
    }
  }

  checkNet() async {}
}

