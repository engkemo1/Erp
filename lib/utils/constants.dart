import 'package:flutter/material.dart';
import '../models/app_local.dart';
import '../models/printer_method.dart';

class Constants {
// start : ||... ASSETS ...||
  static const String ASSETS_IMAGES_PATH = 'assets/images/';
  static const String API_URL = 'http://dev.accountly.me:3000/';
  bool connected = true;
  static const Color primaryColor =Color(0xff0c61cb);
  static const Color textColor =Color(0xff434a51);
  static const Color textColor2 =Color(0xff113d6b);
  static const Color textColor3 =Color(0xff64819f);
  static   Color background=const Color(0xff113d6b);

  static const List<AppLocal> locales = [
    AppLocal(
        name: 'English',
        local: Locale('en', 'US'),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
        image: 'assets/images/united-kingdom.png',
        icon: 'en'),
    AppLocal(
        name: 'العربية',
        local: Locale('ar', 'SA'),
        style: TextStyle(
          fontSize: 18,

          fontWeight: FontWeight.w400,
          fontFamily: 'Tajawal',
        ),
        image:'assets/images/saudi-arabia.png',
        icon: 'ar'),
  ];
  static  List<PrinterMethod> printerMethod = [
    PrinterMethod(id: 0, nameAR: 'Default Printer', nameEN: 'Default Printer'),
    PrinterMethod(id: 2, nameAR: 'TSC', nameEN: 'TSC'),
    PrinterMethod(id: 3, nameAR: 'Zebra', nameEN: 'Zebra'),
    PrinterMethod(id: 4, nameAR: 'Honeywell', nameEN: 'Honeywell'),
    PrinterMethod(id: 5, nameAR: 'RPP 300', nameEN: 'RPP 300'),
    PrinterMethod(
        id: 6, nameAR: 'TSC Full Details', nameEN: 'TSC Full Details'),
    PrinterMethod(
        id: 7, nameAR: 'Honeywell Interme', nameEN: 'Honeywell Interme'),
    PrinterMethod(
        id: 8, nameAR: 'Diesel / Gas Printer', nameEN: 'Diesel / Gas Printer'),
    PrinterMethod(id: 9, nameAR: 'Woosim', nameEN: 'Woosim'),
    PrinterMethod(
        id: 10,
        nameAR: 'Default Printer Small',
        nameEN: 'Default Printer Small'),
    PrinterMethod(
        id: 11,
        nameAR: 'Wallet ERP Printer Graphic',
        nameEN: 'Wallet ERP Printer Graphic'),
    PrinterMethod(
        id: 11,
        nameAR: 'Wallet ERP Printer Text',
        nameEN: 'Wallet ERP Printer Text'),
  ];

}
bool connected = true;