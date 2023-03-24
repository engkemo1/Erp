import 'package:get/get.dart';
import '../models/user/user.dart';

class AppController extends GetxController{
  Rx<UserCompany> userCompany=UserCompany().obs;

}