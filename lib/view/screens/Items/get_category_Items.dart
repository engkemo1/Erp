import 'package:firstprojects/models/items_model/category_item_model.dart';
import 'package:firstprojects/utils/colors.dart';
import 'package:firstprojects/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../models/invoices_model/get_invoice_id_model/get_invoice_id.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/entry_field_widget.dart';
import '../image_view_screen.dart';
import 'article_report.dart';

class GetCategoryScreenItem extends StatefulWidget {
  final CategoryItemModel category;
  final bool isMaterial;
  final bool isEmpty;

  final List<InventoryTransactionItems> items;

  GetCategoryScreenItem(
      {Key? key,
      required this.isMaterial,
      required this.category,
      required this.items,
      required this.isEmpty})
      : super(key: key);

  @override
  _GetCategoryScreenItemState createState() => _GetCategoryScreenItemState();
}

class _GetCategoryScreenItemState extends State<GetCategoryScreenItem> {
  int value = -1;
  bool isOpen = false;
  List<Items> listItems = [];
  List<Items> categoryItemModelList = [];
  TextEditingController searchController = TextEditingController();
  final _focusNode = FocusNode();
  TextEditingController discountController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController aftController = TextEditingController();
  TextEditingController bTaxController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  FocusNode text2FocusNode = FocusNode();
  FocusNode text3FocusNode = FocusNode();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        discountController.selection = TextSelection(
            baseOffset: 0, extentOffset: discountController.text.length);
      }
    });
    text2FocusNode.addListener(() {
      if (text2FocusNode.hasFocus) {
        priceController.selection = TextSelection(
            baseOffset: 0, extentOffset: priceController.text.length);
      }
    });
    text3FocusNode.addListener(() {
      if (text3FocusNode.hasFocus) {
        quantityController.selection = TextSelection(
            baseOffset: 0, extentOffset: quantityController.text.length);
      }
    });

    setState(() {
      listItems = widget.category.items!;
    });

    if (widget.isEmpty == true) {
      widget.category.items!.forEach((element) {
        element.quantity = 0;
      });
    }
  }

  List<Items> inventoryTransactionItemsList = [];

  int _discountType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
          onTap: () {
            _handleSelectItemDone();
          },
          height: 50.h,
          width: 300.w,
          text: 'Add material'.tr,
        ),
      ),
      appBar: AppBar(
        title: Text(widget.category.nameAr!),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: EntryField(
                    hasBorder: Get.isDarkMode ? false : true,
                    hint: 'Search here'.tr,
                    icon: const Icon(Icons.search),
                    filled: true,
                    controller: searchController,
                    onChanged: (value) {
                      addSearchToList(value);
                    },
                    tail: searchController.text.isEmpty
                        ? const SizedBox()
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                searchController.clear();
                                categoryItemModelList.clear();
                              });
                            },
                            icon: const Icon(Icons.clear_outlined)),
                    isCenter: false,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Expanded(
              child: CupertinoScrollbar(
                scrollbarOrientation: ScrollbarOrientation.right,
                thickness: 4.0,
                thicknessWhileDragging: 10.0,
                radius: const Radius.circular(32.0),
                controller: scrollController,
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
                    child: Theme(
                        data: ThemeData(dividerColor: Colors.transparent),
                        child: listItems.isNotEmpty
                            ? ListView.builder(
                                controller: scrollController,
                                itemCount: listItems.length,
                                itemBuilder: (context, index) {
                                  return itemWidget(context, listItems[index]);
                                })
                            : _noneWidget())),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noneWidget() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Group 14.png',
              height: 150,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'there are no items'.tr,
              style: TextStyle(
                  color: Constants.textColor2,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Add items to your account'.tr,
                style: TextStyle(color: Constants.textColor3, fontSize: 16.sp)),
          ],
        ));
  }

  void _handleEditItemAction(Items item) {
    setState(() {
      if (_discountType == 0) {
        item.discountPercentage = int.tryParse(discountController.text);
        item.discountAmount = 0;
      } else if (_discountType == 1) {
        item.discountAmount = int.tryParse(discountController.text);
        item.discountPercentage = 0;
      }
      item.currentPriceBeforeTax =
          double.tryParse(priceController.text) ?? item.currentPriceBeforeTax;
      item.quantity = int.tryParse(quantityController.text) ?? item.quantity;
    });
    Get.back();
  }

  _handleShowBottomSheet(Items item) {
    priceController.text = item.currentPriceBeforeTax.toString();
    discountController.text =
        item.discount == null ? '0.00' : item.discount.toString();
    quantityController.text = item.quantity.toString();
    Navigator.pop(context);
    showModalBottomSheet<void>(
      backgroundColor: Get.isDarkMode ? DARK_GREY3 : Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 500.h,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    item.nameAr!,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode
                            ? Colors.white
                            : Constants.textColor2),
                  ),
                  Text(
                    '${item.currentQuantity} ${item.itemUnit!.nameAr ?? ''}',
                    style: TextStyle(
                      color: item.currentQuantity!.isEven
                          ? Colors.green
                          : Colors.red.shade700,
                      fontSize: 16.sp,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    color: Colors.black38,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 0.2.sw,
                              child: Text(
                                'Quantity'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Constants.primaryColor,
                                    fontSize: 18.sp),
                              ),
                            ),
                            SizedBox(
                              width: 0.7.sw,
                              height: 50.h,
                              child: TextField(
                                controller: quantityController,
                                textAlign: TextAlign.center,
                                focusNode: text3FocusNode,
                                onSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(text2FocusNode);
                                },
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Constants.textColor),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  hintText: 'Quantity'.tr,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r))),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r))),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 2,
                          thickness: 0,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 0.2.sw,
                              child: Text(
                                'Price'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Constants.primaryColor,
                                    fontSize: 18.sp),
                              ),
                            ),
                            SizedBox(
                              width: 0.7.sw,
                              height: 50.h,
                              child: TextField(
                                controller: priceController,
                                focusNode: text2FocusNode,
                                onSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNode);
                                },
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Constants.textColor),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: '0.000',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r))),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r))),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 2,
                          thickness: 0,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: <Widget>[
                            // Radio Button

                            Expanded(
                              child: _myRadioButton(
                                'discount percentage'.tr,
                                0,
                                (newValue) =>
                                    setState(() => _discountType = newValue!),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: _myRadioButton(
                                'discount value'.tr,
                                1,
                                (newValue) =>
                                    setState(() => _discountType = newValue!),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 0.2.sw,
                              child: Text(
                                'Discount'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Constants.primaryColor,
                                    fontSize: 18.sp),
                              ),
                            ),
                            SizedBox(
                              width: 0.7.sw,
                              height: 50.h,
                              child: TextField(
                                controller: discountController,
                                focusNode: _focusNode,
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Constants.textColor),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  hintText: 'Discount'.tr,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r))),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r))),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0.r),
                          child: CustomButton(
                            onTap: () {
                              _handleEditItemAction(item);
                            },
                            height: 50.h,
                            width: ScreenUtil().screenWidth,
                            text: 'Add material'.tr,
                            textStyle:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
      },
    );
  }

  _handleShowItemOption(Items item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Get.isDarkMode ? DARK_GREY3 : Colors.white,
          title: Text(
            'financial portfolio system'.tr,
            style: TextStyle(
                color: Constants.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp),
          ),
          content: Text(
            item.nameAr.toString(),
            style: TextStyle(
                color:
                    Get.isDarkMode ? Colors.blueGrey : Constants.primaryColor,
                fontSize: 15.sp),
          ),
          scrollable: true,
          actionsOverflowAlignment: OverflowBarAlignment.start,
          actions: [
            TextButton(
                onPressed: () {
                  widget.isMaterial == true
                      ? buildBottomSheet(item)
                      : _handleShowBottomSheet(item);
                },
                child: Text(
                  'Add material'.tr,
                  style: TextStyle(
                      color:
                          Get.isDarkMode ? Colors.white : Constants.textColor,
                      fontSize: 15.sp),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Get.to(ImageView(
                    imageUrl: item.imageUrl!,
                  ));
                },
                child: Text(
                  'view photo'.tr,
                  style: TextStyle(
                      color:
                          Get.isDarkMode ? Colors.white : Constants.textColor,
                      fontSize: 15.sp),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'catalog view'.tr,
                  style: TextStyle(
                      color:
                          Get.isDarkMode ? Colors.white : Constants.textColor,
                      fontSize: 15.sp),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ArticleReport(
                          itemId: widget.category.id!,
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  'Reports material to customer'.tr,
                  style: TextStyle(
                      color:
                          Get.isDarkMode ? Colors.white : Constants.textColor,
                      fontSize: 15.sp),
                )),
            TextButton(
              onPressed: () {},
              child: const SizedBox(
                height: 0,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> buildBottomSheet(Items item) {
    return Get.bottomSheet(
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
          child: SizedBox(
            height: 150.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Quantity'.tr,
                        style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.white
                                : Constants.primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 4,
                      child: EntryField(
                        inputType: TextInputType.number,
                        controller: quantityController,
                        isCenter: true,
                        hint: 'Quantity'.tr,
                        hasBorder: Get.isDarkMode ? false : true,
                        filled: false,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  onTap: () {
                    item.quantity = int.tryParse(quantityController.text);
                    setState(() {});
                    quantityController.clear();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  height: 50.h,
                  text: 'Update'.tr,
                  textColor: Colors.white,
                  color: const Color(0xff0C61C9),
                ),
              ],
            ),
          )),
      backgroundColor: Get.isDarkMode ? DARK_GREY3 : Colors.white,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
    );
  }

  itemWidget(BuildContext context, Items item) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        children: [
          InkWell(
              onTap: () {
                _handleShowItemOption(item);
              },
              child: Container(
                padding: const EdgeInsets.all(1),
                child: Row(
                  children: [
                    FittedBox(
                        child: Row(
                      children: [
                        Container(
                            height: 65.h,
                            width: 65.w,
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Colors.black12
                                    : Constants.textColor2.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: item.imageUrl != null &&
                                      item.imageUrl!.isNotEmpty
                                  ? Image.network(item.imageUrl!)
                                  : SvgPicture.asset(
                                      'assets/images/amount.svg',
                                      height: 10,
                                      color: Constants.primaryColor,
                                    ),
                            )),
                        const SizedBox(
                          width: 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  FittedBox(
                                    child: SizedBox(
                                        width: 150,
                                        child: RichText(
                                          text: TextSpan(
                                            text: '',
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: Get.locale!
                                                              .languageCode ==
                                                          'ar'
                                                      ? item.nameAr
                                                      : item.nameEn,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 21.sp,
                                                      color: Get.isDarkMode
                                                          ? Colors.white
                                                          : Constants
                                                              .primaryColor)),
                                              const TextSpan(text: ' - '),
                                              TextSpan(
                                                text:
                                                    Get.locale!.languageCode ==
                                                            'ar'
                                                        ? item.itemUnit!
                                                                .nameAr ??
                                                            ''
                                                        : item.itemUnit!
                                                                .nameEn ??
                                                            '',
                                                style: TextStyle(
                                                    color: item.itemUnit!.id ==
                                                            1
                                                        ? Colors.green
                                                        : item.itemUnit!.id == 2
                                                            ? Colors.blue
                                                            : Colors
                                                                .red.shade700,
                                                    fontSize: 19.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Row(
                                children: [
                                  Text(
                                    'the price:'.tr,
                                    style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.grey
                                          : Constants.textColor2,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    item.currentPriceBeforeTax
                                        .toStringAsFixed(3),
                                    style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.grey
                                          : Constants.textColor2,
                                      fontSize: 17.sp,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (item.quantity! > 0) {
                                    setState(() {
                                      item.quantity = item.quantity! - 1;
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 3,
                                        color: Colors.blueGrey.shade100,
                                      )),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.blueGrey.shade100,
                                    size: 30,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Text(
                                  item.quantity.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.sp,
                                    color: Constants.primaryColor,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (item.quantity != item.currentQuantity) {
                                    setState(() {
                                      item.quantity = item.quantity! + 1;
                                    });
                                  }

                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 3,
                                        color: Colors.blueGrey.shade100,
                                      )),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.blueGrey.shade100,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Current quantity'.tr,
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.blueGrey
                                        : Colors.blue.shade800,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Text(
                                item.currentQuantity.toString(),
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.blueGrey
                                        : Colors.blue.shade800,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Divider(
            height: 15.h,
            color: Colors.black38,
          ),
        ],
      );
    });
  }

  void _handleSelectItemDone() {
    for (Items item in listItems) {
      if (item.quantity! > 0) {
        inventoryTransactionItemsList.add(item);
      }
    }

    Get.back(result: inventoryTransactionItemsList);
  }

  void addSearchToList(String searchName) {
    if (searchName.isNotEmpty) {
      var categoryItemModelList = widget.category.items!.where((item) {
        return item.nameAr!.toLowerCase().contains(searchName.toLowerCase());
      }).toList();
      setState(() {
        listItems = categoryItemModelList;
      });
    } else {
      setState(() {
        listItems = widget.category.items!;
      });
    }
  }

  Widget _myRadioButton(
      String title, int value, void Function(int? object) onChanged) {
    return RadioListTile(
      value: value,
      groupValue: _discountType,
      onChanged: onChanged,
      title: FittedBox(
        child: Text(title),
      ),
    );
  }
}
