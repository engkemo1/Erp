import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';
import 'entry_field_widget.dart';

class SelectableEntryField<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) textValue;
  final void Function(T)? onSelect;
  final Widget? icon;
  final double? sizeValue;
  final double? raduis;

  final String? hint;
  final String? label;
  final bool? isCenter;
  final bool hasBorder;
  final bool hasTitle;
  final Color? valueColor;
  final Color? labelColor;
  final Color? color;
  final EdgeInsets? padding;
  final TextStyle? hintStyle;
  final bool enableOnTab;
  final bool? hasValue;
  final TextEditingController? controller;
  final FontWeight? valueWeight;
  final FontWeight? labelWeight;
  final String? selectValue;
  final String? selected;
  final bool? hasSize;

  const SelectableEntryField({
    Key? key,
    required this.items,
    required this.textValue,
    this.icon,
    this.hint,
    this.onSelect,
    this.color,
    this.padding,
    this.hasBorder = true,
    this.hasTitle = true,
    this.hintStyle,
    this.label,
    required this.enableOnTab,
    this.isCenter,
    this.valueColor,
    this.valueWeight,
    this.hasValue = false,
    this.labelColor,
    this.labelWeight,
    this.controller,
    this.selectValue,
    this.sizeValue,
    this.selected,
    this.hasSize,
    this.raduis,
  }) : super(key: key);

  @override
  State<SelectableEntryField<T>> createState() =>
      _SelectableEntryFieldState<T>();
}

class _SelectableEntryFieldState<T> extends State<SelectableEntryField<T>> {
  T? selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.selected == null) {
      selectedValue = widget.items.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Theme.of(context).cardColor,
        onTap: !widget.enableOnTab
            ? null
            : () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).dialogBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...widget.items.map((e) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop(e);
                                  },
                                  child: ListTile(
                                    leading: widget.icon,
                                    title: Text(
                                      widget.textValue(e),
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  )))
                            ],
                          ),
                        ),
                      );
                    }).then((value) {
                  if (value != null) {
                    setState(() {
                      selectedValue = value as T;

                      if (widget.onSelect != null) {
                        widget.onSelect!(selectedValue!);
                      }
                    });
                  }
                });
              },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.label != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label ?? '',
                        style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.grey
                                : widget.labelColor ?? Constants.textColor2,
                            fontSize: 18.sp,
                            fontWeight: widget.labelWeight ?? FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  )
                : SizedBox(),
            Container(
              decoration: BoxDecoration(
                  color: widget.color,
                  border: !widget.hasBorder
                      ? null
                      : Border.all(
                          color: Get.isDarkMode
                              ? Colors.blueGrey
                              : Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(widget.raduis ?? 10)),
              child: Row(
                children: [
                  widget.icon ??
                      Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      Text(
                        widget.hint ?? '',
                        style: widget.hintStyle ??
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const Spacer(),
                      widget.hasSize != null
                          ? Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.h),
                                child: Text(
                                    selectedValue != null
                                        ? ' ${widget.textValue(selectedValue!)}'
                                        : widget.selected!,
                                    style: TextStyle(
                                      color: widget.valueColor ??
                                          (Get.isDarkMode
                                              ? Constants.primaryColor
                                              : Constants.textColor3),
                                      fontWeight:
                                          widget.valueWeight ?? FontWeight.w500,
                                      fontSize: widget.sizeValue ?? 15.sp,
                                    ),
                                    textAlign: TextAlign.center),
                              ),
                            )
                          : Get.isDarkMode
                          ?  Container(
                              height: 45,
                              width: 110,
                              decoration: const BoxDecoration(
                                      borderRadius:BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: Colors.blueGrey)
                                 ,
                              child: Center(
                                child: Text(
                                    selectedValue != null
                                        ? ' ${widget.textValue(selectedValue as T)}'
                                        : widget.selected!,
                                    style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight:
                                          widget.valueWeight ?? FontWeight.w500,
                                      fontSize: widget.sizeValue ?? 15.sp,
                                    ),
                                    textAlign: TextAlign.center),
                              )): SizedBox(height:45 ,child:
                     Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),child:  Text(
                         selectedValue != null
                             ? ' ${widget.textValue(selectedValue as T)}'
                             : widget.selected!,
                         style: TextStyle(
                           color: Get.isDarkMode
                               ? Colors.white
                               : Colors.grey,
                           fontWeight:
                           widget.valueWeight ?? FontWeight.w500,
                           fontSize: widget.sizeValue ?? 15.sp,
                         ),
                         textAlign: TextAlign.center),),)
                    ],
                  ))
                ],
              ),
            )
          ],
        ));
  }
}
