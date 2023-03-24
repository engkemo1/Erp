import 'package:firstprojects/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'default_item_widget.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return DefaultItemWidget.smallIcon(
      onTap: () {
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1))
            .then((value) {
          if (value != null) {
            setState(() {
              selectedDate = value;
            });
          }
        });
      },
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      icon: Icon(
        Icons.date_range,
        color: Colors.blue.shade600,
      ),
      title: TextFormField(
        enabled: false,
        decoration: InputDecoration(
            hintText: 'Date'.tr,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: !Get.isDarkMode ? Colors.grey : Colors.blue.shade900,
            ),
            border: InputBorder.none),
      ),
      tail: Text(
        selectedDate == null ? '2022-2-14' : formatDate(selectedDate!),
        style: TextStyle(
            color: Colors.blue, fontSize: 14.sp, fontWeight: FontWeight.w800),
      ),
    );
  }
}
