import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firstprojects/controllers/cubit/material_cubit/material_state.dart';
import 'package:firstprojects/utils/colors.dart';
import 'package:firstprojects/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/cubit/material_cubit/material_cubit.dart';
import '../../../models/invoices_model/get_invoice_id_model/get_invoice_id.dart';
import '../../../models/items_model/category_item_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/entry_field_widget.dart';
import 'get_category_Items.dart';

class ItemCategoriesScreen extends StatefulWidget {
  final bool isMaterial;

  const ItemCategoriesScreen({Key? key, required this.isMaterial})
      : super(key: key);

  @override
  _ItemCategoriesScreenstate createState() => _ItemCategoriesScreenstate();
}

class _ItemCategoriesScreenstate extends State<ItemCategoriesScreen> {
  int value = -1;
  bool isOpen = false;

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<InventoryTransactionItems> inventoryTransactionItemsList = [];
  @override
  void initState() {
    inventoryTransactionItemsList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => MaterialCubit()..getCategoryItem(),
      child: BlocConsumer<MaterialCubit, MaterialMainState>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            var data = MaterialCubit.get(context);
            return state is GetMaterialLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: EntryField(
                                  hasBorder: Get.isDarkMode ? false : true,
                                  hint: 'Search here'.tr,
                                  icon: const Icon(Icons.search),
                                  filled: true,
                                  controller: searchController,
                                  onChanged: (value) {
                                    data.addSearchToList(value);
                                  },
                                  tail: searchController.text.isEmpty
                                      ? const SizedBox()
                                      : IconButton(
                                          onPressed: () {
                                            searchController.clear();
                                            data.categoryItemSearchList.clear();
                                          },
                                          icon:
                                              const Icon(Icons.clear_outlined)),
                                  isCenter: false,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    searchController.clear();
                                    data.categoryItemSearchList.clear();
                                    if (inventoryTransactionItemsList.isEmpty) {
                                      Navigator.pop(context);
                                    } else {
                                      buildAwesomeDialogBack(context).show();
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.close_rounded,
                                    color: Colors.blueGrey,
                                    size: 30,
                                    shadows: [
                                      BoxShadow(
                                          color: Colors.blueGrey,
                                          blurRadius: 5,
                                          blurStyle: BlurStyle.solid)
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        data.categoryItemSearchList.isEmpty
                            ? searchController.text.isEmpty
                                ? Expanded(
                                    child: CupertinoScrollbar(
                                    scrollbarOrientation:
                                        ScrollbarOrientation.right,
                                    thickness: 4.0,
                                    thicknessWhileDragging: 10.0,
                                    radius: const Radius.circular(32.0),
                                    controller: scrollController,
                                    child: ListView.separated(
                                        controller: scrollController,
                                        itemCount:
                                            data.categoryItemModelList.length,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                              height: 5,
                                            ),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            color: Get.isDarkMode
                                                ? DARK_GREY3
                                                : Colors.white,
                                            child: Theme(
                                                data: ThemeData(
                                                    dividerColor:
                                                        Colors.transparent),
                                                child: InkWell(
                                                  onTap: () {
                                                    onTap(
                                                        data.categoryItemModelList[
                                                            index]);
                                                  },
                                                  child: ListTile(
                                                    trailing: Icon(
                                                      Get.locale!.languageCode ==
                                                              'ar'
                                                          ? Icons
                                                              .arrow_back_ios_new_outlined
                                                          : Icons
                                                              .arrow_forward_ios_outlined,
                                                      color: Get.isDarkMode
                                                          ? Colors.blueGrey
                                                          : Constants.textColor,
                                                      size: 30,
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          Get.locale!.languageCode ==
                                                                  'ar'
                                                              ? data
                                                                  .categoryItemModelList[
                                                                      index]
                                                                  .nameAr
                                                                  .toString()
                                                              : data
                                                                  .categoryItemModelList[
                                                                      index]
                                                                  .nameEn
                                                                  .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Get
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                : Constants
                                                                    .textColor2,
                                                            fontSize: 27.sp,
                                                          ),
                                                        ),
                                                        RichText(
                                                            text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: '(',
                                                              style: TextStyle(
                                                                color: Get
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .blueGrey
                                                                    : Constants
                                                                        .textColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18.sp,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: data
                                                                  .categoryItemModelList[
                                                                      index]
                                                                  .items!
                                                                  .length
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: Get
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .blueGrey
                                                                    : Constants
                                                                        .textColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18.sp,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  'product'.tr,
                                                              style: TextStyle(
                                                                color: Get
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .blueGrey
                                                                    : Constants
                                                                        .textColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18.sp,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                                text: ')',
                                                                style:
                                                                    TextStyle(
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .blueGrey
                                                                      : Constants
                                                                          .textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16.sp,
                                                                ))
                                                          ],
                                                        )),
                                                        const SizedBox(
                                                          height: 2,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                          );
                                        }),
                                  ))
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          style: TextStyle(
                                              color: Constants.textColor3,
                                              fontSize: 16.sp)),
                                    ],
                                  )
                            : Expanded(
                                child: ListView.separated(
                                    itemCount:
                                        data.categoryItemSearchList.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 5,
                                        ),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.h),
                                        color: Get.isDarkMode
                                            ? DARK_GREY3
                                            : Colors.white,
                                        child: Theme(
                                            data: ThemeData(
                                                dividerColor:
                                                    Colors.transparent),
                                            child: InkWell(
                                              onTap: () {
                                                onTap(
                                                    data.categoryItemSearchList[
                                                        index]);
                                              },
                                              child: ListTile(
                                                trailing: Icon(
                                                  Icons
                                                      .arrow_back_ios_new_outlined,
                                                  color: Get.isDarkMode
                                                      ? Colors.blueGrey
                                                      : Constants.textColor,
                                                  size: 30,
                                                ),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data
                                                          .categoryItemSearchList[
                                                              index]
                                                          .nameAr
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Constants
                                                                .textColor2,
                                                        fontSize: 40.sp,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'product'.tr,
                                                          style: TextStyle(
                                                            color: Get.isDarkMode
                                                                ? Colors
                                                                    .blueGrey
                                                                : Constants
                                                                    .textColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 30.sp,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(data
                                                            .categoryItemModelList[
                                                                index]
                                                            .items!
                                                            .length
                                                            .toString()),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                      );
                                    })),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                              onTap: () {
                                Get.back(result: inventoryTransactionItemsList);
                              },
                              height: 50.h,
                              width: 300.w,
                              text: 'Add material'.tr,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
          }),
    ));
  }

  onTap(CategoryItemModel category) {
    bool isEmpty = false;
    if (inventoryTransactionItemsList.isEmpty) {
      isEmpty = true;
      setState(() {});
    }

    Get.to((GetCategoryScreenItem(
      isEmpty: isEmpty,
      items: inventoryTransactionItemsList,
      isMaterial: widget.isMaterial,
      category: category,
    )))?.then((value) {
      if (value != null) {
        value.forEach((element) {
          print(element.nameAr);
        });
        print(value.length);
        //  value = value as List<Item>;

        for (Items item in value) {
          InventoryTransactionItems object = InventoryTransactionItems();

          object.quantity = item.quantity;
          object.itemId = 2;
          object.itemName = item.nameAr ?? '';
          object.lastCost = 0;
          object.customerSalesPrice = 0;
          object.weight = 0;
          object.itemUnitName = item.itemUnit!.nameAr;
          object.avgCost = 0;
          object.lowerCost = 0;
          object.biggestCost = 0;
          object.customerSalesPrice = 21;
          object.itemUnitId = item.itemUnit!.id;
          object.taxPercentage = 0;
          object.price = 31;
          object.rate = '2';
          object.itemInfoId = 31;
          object.totalAfterTax = item.currentPriceAfterTax ?? 0;
          object.totalBeforeTax = item.currentPriceBeforeTax ?? 0;
          object.taxAmount = item.taxAmount ?? 0;
          object.itemNumber = item.itemNumber;
          object.nameAr = item.nameAr;
          object.isPercentage = item.isPercentage;
          object.nameEn = item.nameEn;
          object.discountAmount = item.discountAmount ?? 0;
          object.discountPercentage = item.discountPercentage ?? 0;
          var index = inventoryTransactionItemsList
              .indexWhere((element) => element.nameAr == item.nameAr);
          print(index);
          if (index != -1) {
            inventoryTransactionItemsList.removeAt(index);
            inventoryTransactionItemsList.add(object);
          } else if (index == -1) {
            inventoryTransactionItemsList.add(object);
          }
        }

        inventoryTransactionItemsList.forEach((element) {
          print(element.nameAr);
        });

        print(inventoryTransactionItemsList.length);
      }
    });
  }

  buildAwesomeDialogBack(BuildContext context) {
    return AwesomeDialog(
      dialogBackgroundColor: Get.isDarkMode ? DARK_GREY : Colors.white,
      context: context,
      padding: const EdgeInsets.all(20),
      btnCancel: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'YES'.tr,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: 40.w,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'NO'.tr,
              style: const TextStyle(
                  color: Constants.primaryColor, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Back'.tr,
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white70 : Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Are you sure you want to back'.tr,
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white70 : Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp),
            textAlign: TextAlign.end,
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
    );
  }
}
