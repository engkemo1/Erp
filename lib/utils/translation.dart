import 'package:get/route_manager.dart';
import '../utils_lang/ar.dart';
import '../utils_lang/en.dart';
import 'package:get/get.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}
