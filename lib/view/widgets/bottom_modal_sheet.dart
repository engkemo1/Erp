import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';

class ModalBottomSheet {
  static void moreModalBottomSheet(context,Widget w, double? height) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: height??size.height * 0.4,
            decoration: BoxDecoration(
              color: Get.isDarkMode? DARK_GREY3:Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: /*ListView(
                physics: ClampingScrollPhysics(),
                children: w,
              )*/
              w,
            ),
          );
        });
  }
}