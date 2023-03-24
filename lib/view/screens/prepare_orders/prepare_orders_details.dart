import 'package:firstprojects/view/screens/prepare_orders/prepare_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/cubit/prepare_goods_cubit/prepare_goods_cubit.dart';
import '../../../models/invoices_model/get_invoice_id_model/get_invoice_id.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/storage.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/date_entry_field.dart';
import '../../widgets/entry_field_widget.dart';
import '../../widgets/app_bar_widget/rounded_app_bar.dart';
import '../items/item_categories_screen.dart';

class PrepareOrdersDetailsScreen extends StatefulWidget {
  PrepareOrdersDetailsScreen({Key? key, this.prepareGoodModel})
      : super(key: key);
  GetInvoiceIdModel? prepareGoodModel;
  @override
  _PrepareOrdersDetailsScreenState createState() =>
      _PrepareOrdersDetailsScreenState();
}

class _PrepareOrdersDetailsScreenState
    extends State<PrepareOrdersDetailsScreen> {
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController qController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  List<InventoryTransactionItems> inventoryTransactionItemsList = [];

  @override
  void initState() {
    if (widget.prepareGoodModel != null) {
      serialNumberController.text =
          widget.prepareGoodModel!.bondSerial.toString();
      inventoryTransactionItemsList
          .addAll(widget.prepareGoodModel!.inventoryTransactionItems!);

      notesController.text = widget.prepareGoodModel!.notes ?? '';
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        onTap: () {
          Get.to(const PrepareOrdersScreen());
        },
        icon: const Icon(Icons.receipt_long_outlined),
        title: 'Prepare orders'.tr,
        subtitle:
            'You can request items and products from the administration before the start of the working day.'
                .tr,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.to(const PrepareOrdersScreen());
          return false;
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Get.isDarkMode ? DARK_GREY3 : Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Serial Number'.tr,
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Constants.textColor2,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          EntryField(
                            controller: serialNumberController,
                            hasBorder: true,
                            isCenter: false,
                            filled: false,
                            enabled: false,
                            hint: 'Serial Number'.tr,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DateEntryField(
                            fontWeight: FontWeight.bold,
                            enable: false,
                            filled: true,
                            label: 'Date'.tr,
                            textEditingController: _dateController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'add notes'.tr,
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Constants.textColor2,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          EntryField(
                            controller: notesController,
                            hasBorder: true,
                            filled: false,
                            isCenter: false,
                            hint: 'add notes'.tr,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    inventoryTransactionItemsList.isNotEmpty
                        ? buildList(context, inventoryTransactionItemsList)
                        : empty(),
                    SizedBox(
                      height: 30.h,
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12) +
            const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {
                  Get.to(const ItemCategoriesScreen(
                    isMaterial: true,
                  ))!
                      .then((value) {
                    if (value != null) {
                      inventoryTransactionItemsList.addAll(value);

                      setState(() {});
                    }
                  });
                },
                child: Container(
                  width: 53.w,
                  height: 53.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        width: 2,
                        color: Constants.primaryColor,
                      )),
                  child: const Icon(
                    Icons.add,
                    size: 35,
                    color: Constants.primaryColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: CustomButton(
                  onTap: () {
                    final String selectedDate =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
                    GetInvoiceIdModel invoicesModel = GetInvoiceIdModel(
                        id: widget.prepareGoodModel != null
                            ? widget.prepareGoodModel!.id
                            : 0,
                        uuid: widget.prepareGoodModel != null
                            ? widget.prepareGoodModel!.uuid
                            : '0',
                        bondSerial: widget.prepareGoodModel != null
                            ? widget.prepareGoodModel!.bondSerial
                            : 0,
                        transactionNo: widget.prepareGoodModel != null
                            ? widget.prepareGoodModel!.transactionNo
                            : 0,
                        accountName: widget.prepareGoodModel != null
                            ? widget.prepareGoodModel!.accountName
                            : 'Hasan',
                        notes: notesController.text ?? '',
                        transactionDate: _dateController.text == ''
                            ? selectedDate
                            : _dateController.text,
                        purchaseOrderNumber: '',
                        invoiceTypeId: widget.prepareGoodModel != null
                            ? widget.prepareGoodModel!.invoiceTypeId
                            : 2,
                        accountBranchId: widget.prepareGoodModel != null
                            ? widget.prepareGoodModel!.accountBranchId
                            : 0,
                        branchId: 1,
                        batchId: 7,
                        departmentId: 1,
                        accountId: widget.prepareGoodModel != null
                            ? widget.prepareGoodModel!.accountId
                            : 3886,
                        salesmanId: getUser()!.userCompanies!.first.salesmanId,
                        storeId: widget.prepareGoodModel != null
                            ? widget.prepareGoodModel!.storeId
                            : 12,
                        fromStoreId: widget.prepareGoodModel != null
                            ? widget.prepareGoodModel!.fromStoreId
                            : 55,
                        toStoreId: widget.prepareGoodModel != null
                            ? widget.prepareGoodModel!.toStoreId
                            : 71,
                        taxTypeId: 0,
                        source: widget.prepareGoodModel != null
                            ? widget.prepareGoodModel!.source
                            : 'mobile',
                        totalBeforeTax: 212,
                        tax: 2,
                        discount: 2,
                        totalAfterTax: 21,
                        totalChecks: widget.prepareGoodModel != null
                            ? widget.prepareGoodModel!.totalChecks
                            : 0,
                        userId: getUser()!.id,
                        inventoryTransactionItems:
                            inventoryTransactionItemsList);

                    if (widget.prepareGoodModel == null) {
                      if (inventoryTransactionItemsList.isNotEmpty) {
                        PrepareGoodsCubit().createPrepareGood(invoicesModel);
                      }
                    } else {
                      PrepareGoodsCubit().updatePrepareGood(invoicesModel);
                    }
                  },
                  text: 'Confirmation'.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildList(BuildContext context,
      List<InventoryTransactionItems> inventoryTransactionItemsList) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        //   D
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode ? DARK_GREY3 : Colors.white),
        child: Column(
          children: [
            ...List.generate(
                inventoryTransactionItemsList.length,
                (index) => InkWell(
                      onTap: () {
                        buildBottomSheet(inventoryTransactionItemsList[index]);
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                '${inventoryTransactionItemsList[index].itemName} _${inventoryTransactionItemsList[index].itemUnitName}',
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Constants.primaryColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Quantity'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Constants.textColor3,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            inventoryTransactionItemsList[index]
                                .quantity
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.grey
                                    : Constants.primaryColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 15.h),
              decoration: const BoxDecoration(
                  color: Color(0xff113D6A),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    'Number of items'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    inventoryTransactionItemsList.length.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildBottomSheet(InventoryTransactionItems item) {
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
                        controller: qController,
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
                    item.quantity = int.tryParse(qController.text);
                    setState(() {});
                    qController.clear();
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

  empty() {
    return Column(children: [
      const Icon(Icons.add_box_outlined, size: 100),
      const SizedBox(
        height: 10,
      ),
      Text(
        'Add items'.tr,
        style: const TextStyle(color: Constants.primaryColor, fontSize: 20),
      )
    ]);
  }
}
