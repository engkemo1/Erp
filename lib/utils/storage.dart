import 'dart:convert';
import 'package:firstprojects/models/user/user.dart';
import 'package:get_storage/get_storage.dart';
import '../models/transactions_models/sales_men_model/sales_representative.dart';

setLang(String lang) {
  GetStorage().write("lang", lang);
}

void setIsLogin(bool isLogin) {
  GetStorage().write("isLogin", isLogin);
}

bool isLogin() {
  return GetStorage().hasData("isLogin") ? GetStorage().read("isLogin") : false;
}

//
String getlang() {
  return GetStorage().hasData("lang") ? GetStorage().read("lang") : '';
}

setToken(String? token) {
  GetStorage().write("token", token);
}

//
String getToken() {

  return GetStorage().read("token");

}

removeUser() {
  setIsLogin(false);
  GetStorage().remove('user');
}

void setUser(UserModel user) {
  setIsLogin(true);
  if (user.token != null) {
    setToken(user.token);
  }
  GetStorage().write("user", UserModelToJson(user));

  // GetStorage().writeInMemory("user", user);
}

UserModel? getUser() {
  if (!isLogin()) {
    return null;
  }

  return UserModelFromJson(GetStorage().read<String>("user")!);
}
SalesRepresentative? getSalesman() {
  if (!isLogin()) {
    return null;
  }

  return SalesRepresentative.fromJson(jsonDecode(GetStorage().read("salesman")!));
}