import 'dart:convert';
import 'dart:io' show Platform;
import 'package:crypto/crypto.dart';
import 'package:firstprojects/utils/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../api_helper/remote/api_base_helper.dart';
import 'package:http/http.dart' as http;
import '../../../models/user/user.dart';
import '../../../utils/constants.dart';
import '../../../view/screens/auth_screens/login_screen.dart';
import '../rep_visits_cubit/rep_visits_cubit.dart';
import '../sales_man_cubit/sales_man_cubit.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthMainState> {
  AuthCubit() : super(AuthMainInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  final GetStorage authBox = GetStorage();

  // Future checkVersion() async {
  //   String platform = 'android';
  //   if (Platform.isAndroid) {
  //     platform = 'android';
  //   } else if (Platform.isIOS) {
  //     platform = 'ios';
  //     // iOS-specific code
  //   }
  //   String url = "config/$platform";

  //   await ApiBaseHelper()
  //       .get(
  //     url,
  //     null,
  //   )
  //       .then((value) {
  //     GetStorage().write('version', value['version']);
  //   });
  // }

  Future<UserModel> loginAction(String email, String password) async {
    UserModel user;
    emit(LoginLoadingState());
    try {
      String url = "${Constants.API_URL}users/login";

      var response = await http.post(Uri.parse(url), body: {
        "email": email,
        "password": md5.convert(utf8.encode(password)).toString()
      });
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        user = UserModel.fromJson(responsebody);

        emit(LoginSuccessState());
      } else {
        var responseBody = jsonDecode(response.body);
        var message = (responseBody['message']);
        Get.snackbar('Error'.tr, message,
            backgroundColor: Colors.white, colorText: Constants.textColor2);
        throw Exception();
      }
    } on Exception catch (ex) {
      emit(LoginErrorState(ex));
      rethrow;
    }
    return user;
  }

  // Future<UserModel> loginAction(String email, String password) async {
  //   UserModel user = UserModel();
  //
  //     String url = "users/login";
  //
  //     await ApiBaseHelper().post(url, {
  //       "email": 'demo@accountly.me',
  //       "password": md5.convert(utf8.encode('123')).toString()
  //     },header: {
  //       'Content-Type':'application/json'
  //
  //     }).then((value) {
  //       user = UserModel.fromJson(value);
  //       return user;
  //
  //     });
  //   return user;
  //
  // }
  String? getAuthorization() {
    final stroage = GetStorage();
    var x = stroage.read("token");
    return "JWT " + x ?? "null";
  }

  Future backgroundLoction() async {
    dynamic currentLocation;

    String url = "accounting/salesman_location";
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentLocation = position;
      if (kDebugMode) {
        print('CURRENT POS: $currentLocation');
      }
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
    if (kDebugMode) {
      print('CURRENT POS: $currentLocation');
    }
    try {
      await ApiBaseHelper().post(
        url,
        jsonEncode({
          "location": {
            "salesman_id": getUser()!.userCompanies!.first.salesmanId,
            "user_id": getUser()!.id,
            "longitude": currentLocation.longitude,
            "latitude": currentLocation.latitude
          }
        }),
        header: {
          "Authorization": getAuthorization()!,
          'Content-Type': 'application/json'
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  refreshToken() {
    String url = "users/refresh";

    ApiBaseHelper().get(url, null).then((value) {
      GetStorage().write('token', value['token']);
    });
  }

  Future<String> selectCompanyAndBranch(int companyId, int branchId) async {
    String? token;
    emit(SelectCompanyLoadingState());
    try {
      String url = "users/select_company";

      await ApiBaseHelper().post(url, <String, dynamic>{
        "company_id": '$companyId',
        "branch_id": '$branchId'
      }).then((value) {
        getUserSavedData();
        token = value['token'];
        GetStorage().write('token', token);
        SalesManCubit().getSalesmanId();

        emit(SelectCompanySuccessState());
      });
    } catch (ex) {
      emit(SelectCompanyErrorState(ex));
      rethrow;
    }
    return token!;
  }

  Future<String> refreshLogin() async {
    String? token;
    try {
      String url = "users/refresh_login";

      await ApiBaseHelper().post(url, <String, dynamic>{
        "id": 1,
        "company_username": "Meow",
        "email": "Meow@meow.com",
        "expiry_date": "Fri Feb 10 2022 21:47:53 GMT+0200"
      }).then((value) {
        token = value['token'];
        GetStorage().write('token', token);
      });
    } catch (ex) {
      rethrow;
    }
    return token!;
  }

  logoutAction() {
    GetStorage().remove('user').then((value) {
      Get.offAll(() => const LoginScreen());
    });
  }

  UserModel? userSavedData;

  getUserSavedData() async {
    String user = await GetStorage().read("user");

    if (user.isNotEmpty) {
      userSavedData = UserModelFromJson(user);
    }
  }

  ///////////////////////////////////// change pass

  changePass(oldPass, newPass) async {
    String url = "users/reset_password";
    emit(ChangePassLoadingState());
    await ApiBaseHelper().post(url, <String, dynamic>{
      "old_password": '$oldPass',
      "new_password": '$newPass'
    }).then((value) {
      emit(ChangePassSuccessState());
      Get.back();
      Get.snackbar("success", "pass updated success",
          backgroundColor: Colors.grey, colorText: Colors.green);
    }).catchError((e) {
      emit(ChangePassErrorState(e));
      Get.snackbar("error".tr, "${e.body}",
          backgroundColor: Colors.grey, colorText: Colors.red);

      throw Exception();
    });
  }

///////////////////////////////////// change image
  bool isChangingImage = false;

  uploadImage({required String imagePath}) async {
    ApiBaseHelper().postFile(imagePath).then((value) {
      emit(UploadImageSuccessState());
      Get.snackbar("success", '',
          backgroundColor: Colors.white, colorText: Constants.primaryColor);
    });
  }
}
