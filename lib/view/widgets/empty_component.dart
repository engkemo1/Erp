import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';

class EmptyComponent extends StatelessWidget {
  final String? text;
  String iconName;

  EmptyComponent({@required this.text, this.iconName = 'error'});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/noData.svg',
                // color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                text ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white70 : Constants.textColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
