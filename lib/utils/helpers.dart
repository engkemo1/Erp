import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import 'colors.dart';

String formatDate(DateTime dateTime) {
  return intl.DateFormat('yyyy-MM-dd', 'en').format(dateTime);
}

String formatDateWithTime(DateTime dateTime) {
  return intl.DateFormat('yyyy-MM-dd HH:ss', 'en').format(dateTime);
}

String formatTime(TimeOfDay timeOfDay) {
  return '${timeOfDay.hour} : ${timeOfDay.minute}';
}

Future<dynamic> showCustomBottomSheet(BuildContext context, Widget child) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
            decoration: BoxDecoration(
              color: Get.isDarkMode ? DARK_GREY2 : Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
            ),
            child: child);
      });
}
