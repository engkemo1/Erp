import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart' as a;
import 'entry_field_widget.dart';

class DateEntryField extends StatefulWidget {
  final String? hint;
  final Color? color;
  final String? label;
  final FontWeight? fontWeight;
  final a.TextDirection? textDirection;

  final TextEditingController? textEditingController;
  final bool? filled;
  final bool? hasBorder;
  final bool? enable;

  final BuildContext? context;
  const DateEntryField({
    Key? key,
    this.hint,
    required this.textEditingController,
    this.filled,
    this.enable,
    this.color,
    this.hasBorder,
    this.textDirection,
    this.label,
    this.context,
    this.fontWeight,
  }) : super(key: key);

  @override
  State<DateEntryField> createState() => _DateEntryFieldState();
}

class _DateEntryFieldState extends State<DateEntryField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
    widget.textEditingController != TextEditingController();
  }

  String _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context2) {
    return InkWell(
      onTap:widget.enable==true||widget.enable==null? () async {
        final DateTime? selected = await DatePicker.showSimpleDatePicker(
            context,
            initialDate: DateTime.now(),
            dateFormat: "dd-MM-yyyy",
            locale: DateTimePickerLocale.en_us,
            backgroundColor: Colors.white,
            looping: true,
            itemTextStyle: TextStyle(color: Colors.black54),
            titleText: "");

        if (selected != null) {
          setState(() {
            widget.textEditingController!.text =
                DateFormat('yyyy-MM-dd').format(selected).toString();
            _selectedDate =
                DateFormat('yyyy-MM-dd').format(selected).toString();
          });
        } else {
          setState(() {
            _selectedDate =
                DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
          });
        }
      }:null,
      child: EntryField(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        controller: widget.textEditingController!=''?widget.textEditingController:(widget.textEditingController!..text = _selectedDate),
        icon: Icon(
          Icons.calendar_month_outlined,
          color: widget.color ?? const Color(0xff8b92a3),
        ),
        hasBorder: widget.hasBorder ?? true,
        isCenter: false,
        filled: widget.filled ?? false,
        enabled: false,
        color: widget.color,
        label: widget.label,
        labelFontWeight: widget.fontWeight ?? FontWeight.w500,
        hasTitle: true,
        hint: _selectedDate,
      ),
    );
  }
}
