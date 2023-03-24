import 'package:firstprojects/controllers/cubit/transfer_cubit/transfer_cubit.dart';
import 'package:firstprojects/utils/colors.dart';
import 'package:firstprojects/utils/constants.dart';
import 'package:firstprojects/view/screens/transactions/transfer_screen/transfer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../models/invoices_model/get_invoice_id_model/get_invoice_id.dart';
import '../../../../utils/storage.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/date_entry_field.dart';
import '../../../widgets/entry_field_widget.dart';
import '../../Items/item_categories_screen.dart';
import '../../stores_screen/stores_screen_selectable.dart';

class TransferDetailsScreen extends StatefulWidget {
  TransferDetailsScreen({Key? key, this.invoicesModel}) : super(key: key);
  GetInvoiceIdModel? invoicesModel;

  @override
  _TransferDetailsScreenState createState() => _TransferDetailsScreenState();
}

class _TransferDetailsScreenState extends State<TransferDetailsScreen> {
  List<InventoryTransactionItems> inventoryTransactionItemsList = [];
  TextEditingController qController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController toStoresController = TextEditingController();
  TextEditingController fromStoresController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController delegateController = TextEditingController();

  String? name;
  String? salesman;

  int? id;

  @override
  void initState() {
    fromStoresController.text = Get.locale!.languageCode == 'ar'
        ? getSalesman()!.store!.nameAr!.toString()
        : getSalesman()!.store!.nameEn!.toString();

    if (widget.invoicesModel != null) {
      _dateController.text = widget.invoicesModel!.transactionDate.toString();
      inventoryTransactionItemsList
          .addAll(widget.invoicesModel!.inventoryTransactionItems!);
      serialNumberController.text =
          widget.invoicesModel!.transactionNo.toString() ?? '';
      id = widget.invoicesModel!.toStoreId;
      notesController.text = widget.invoicesModel!.notes ?? '';
      if (widget.invoicesModel!.toStore != null) {
        name = widget.invoicesModel!.toStore!.nameAr ?? '';
        salesman = widget.invoicesModel!.toStore!.person!;
      }
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bottom(),
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? DARK_GREY3 : Colors.white,
          centerTitle: true,
          elevation: 1,
          title: Text(
            'Transfer between warehouses'.tr,
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Constants.textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () {
              Get.to(const TransferScreen());
            },
          ),
          actions: [
            getUser()!.welcomeUserPermissions![
                        "transfer_between_stores.print"] ==
                    true
                ? IconButton(
                    icon: const Icon(
                      Icons.print,
                      color: Colors.blueGrey,
                    ),
                    onPressed: () {},
                  )
                : const SizedBox(),
            widget.invoicesModel != null &&
                    widget.invoicesModel!.statusId == 1 &&
                    getUser()!.welcomeUserPermissions![
                            "transfer_between_stores.delete"] ==
                        true
                ? IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      TransferCubit().deleteTransferId(
                          widget.invoicesModel!.uuid.toString()).then((value) =>               Get.to(const TransferScreen())
                      );
                    },
                  )
                : const SizedBox(),
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            Get.to(const TransferScreen());
            return false;
          },
          child: SafeArea(
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Get.isDarkMode ? DARK_GREY3 : Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Information'.tr,
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            EntryField(
                              enabled: false,
                              controller: serialNumberController,
                              hasBorder: Get.isDarkMode ? false : true,
                              filled: false,
                              isCenter: false,
                              hasTitle: true,
                              hint: 'Serial Number'.tr,
                              label: 'Serial Number'.tr,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {},
                              child: EntryField(
                                controller: fromStoresController,
                                filled: true,
                                enabled: false,
                                icon: const Icon(Icons.store),
                                hasTitle: true,
                                hint: 'from stores'.tr,
                                label: 'from stores'.tr,
                                isCenter: false,
                                hasBorder: true,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      if(widget.invoicesModel==null){
                                        Get.to(const StoresScreenSelectable(
                                          isScreen: false,
                                        ))?.then((value) {
                                          if (value != null) {
                                            setState(() {
                                              id = value.first;
                                              name = value.last;
                                              salesman = value[1];
                                            });
                                          }
                                        });

    }else{
                                      if(widget.invoicesModel!.statusId==2){
                                        return ;
                                      }
                                      else{
                                      Get.to(const StoresScreenSelectable(
                                        isScreen: false,
                                      ))?.then((value) {
                                        if (value != null) {
                                          setState(() {
                                            id = value.first;
                                            name = value.last;
                                            salesman = value[1];
                                          });
                                        }
                                      });}}
                                    },
                                    child: EntryField(
                                      controller: toStoresController
                                        ..text = name ?? '',
                                      filled: true,
                                      enabled: false,
                                      icon: const Icon(Icons.store),
                                      hasTitle: true,
                                      hint: 'to stores'.tr,
                                      label: 'to stores'.tr,
                                      isCenter: false,
                                      hasBorder: true,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: EntryField(
                                    controller: delegateController
                                      ..text = salesman ?? '',
                                    filled: true,
                                    enabled: false,
                                    icon: const Icon(
                                      Icons.person_outline,
                                      size: 30,
                                    ),
                                    hasTitle: true,
                                    hint: 'All'.tr,
                                    label: 'Delegate name'.tr,
                                    isCenter: false,
                                    hasBorder: true,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DateEntryField(
                              enable: false,
                              filled: true,
                              label: 'Date'.tr,
                              textEditingController: _dateController,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            EntryField(
                              controller: notesController,
                              isCenter: false,
                              hint: 'Add note'.tr,
                              label: 'Add note'.tr,
                              hasTitle: true,
                              hasBorder: Get.isDarkMode ? false : true,
                              filled: false,
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
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  bottom() {
    return widget.invoicesModel != null
        ? widget.invoicesModel!.statusId == 1
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      widget.invoicesModel!.toStoreId == getSalesman()!.storeId
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                if (widget.invoicesModel!.toStoreId ==
                                    getSalesman()!.storeId) {
                                  return;
                                } else {
                                  Get.to(const ItemCategoriesScreen(
                                    isMaterial: true,
                                  ))!
                                      .then((value) {
                                    if (value != null) {
                                      inventoryTransactionItemsList
                                          .addAll(value);

                                      setState(() {});
                                    }
                                  });
                                }
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
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 35,
                                      color: Constants.primaryColor,
                                    ),
                                  )),
                            ),
                      widget.invoicesModel!.toStoreId == getSalesman()!.storeId
                          ? const SizedBox()
                          : const SizedBox(
                              width: 15,
                            ),
                      Expanded(
                          child: CustomButton(
                        color: widget.invoicesModel!.toStoreId ==
                                getSalesman()!.storeId
                            ? Colors.green
                            : Constants.primaryColor,
                        onTap: () {
                          final String _selectedDate =
                              DateFormat('yyyy-MM-dd').format(DateTime.now());

                          GetInvoiceIdModel invoicesModel = GetInvoiceIdModel(
                              id: widget.invoicesModel!.id,
                              uuid: widget.invoicesModel!.uuid,
                              bondSerial: widget.invoicesModel!.bondSerial,
                              transactionNo:
                                  widget.invoicesModel!.transactionNo,
                              accountName: widget.invoicesModel!.accountName,
                              notes: notesController.text ?? '',
                              transactionDate: _dateController.text == ''
                                  ? _selectedDate
                                  : _dateController.text,
                              purchaseOrderNumber:
                                  widget.invoicesModel!.purchaseOrderNumber,
                              invoiceTypeId:
                                  widget.invoicesModel!.invoiceTypeId,
                              accountBranchId:
                                  widget.invoicesModel!.accountBranchId,
                              branchId: widget.invoicesModel!.branchId,
                              batchId: widget.invoicesModel!.batchId,
                              departmentId: widget.invoicesModel!.departmentId,
                              accountId: widget.invoicesModel!.accountId,
                              salesmanId: widget.invoicesModel!.salesmanId,
                              storeId: getSalesman()!.storeId,
                              fromStoreId: getSalesman()!.storeId,
                              toStoreId: id,
                              taxTypeId: widget.invoicesModel!.taxTypeId,
                              source: widget.invoicesModel!.source,
                              totalBeforeTax:
                                  widget.invoicesModel!.totalAfterTax,
                              tax: widget.invoicesModel!.tax,
                              discount: widget.invoicesModel!.discount,
                              totalAfterTax:
                                  widget.invoicesModel!.totalAfterTax,
                              totalChecks: widget.invoicesModel!.totalChecks,
                              createdAt: _selectedDate,
                              userId: getUser()!.id,
                              inventoryTransactionItems:
                                  inventoryTransactionItemsList);

                          if (widget.invoicesModel!.toStoreId ==
                              getSalesman()!.storeId) {
                            TransferCubit().confirmRequest(
                                widget.invoicesModel!,
                                widget.invoicesModel!.uuid!);
                          } else {
                            TransferCubit().updateTransfer(invoicesModel);
                          }
                        },
                        text: widget.invoicesModel!.toStoreId ==
                                getSalesman()!.storeId
                            ? 'Confirmation'.tr
                            : 'Confirmation'.tr,
                      ))
                    ],
                  ),
                ))
            : const SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 35,
                            color: Constants.primaryColor,
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: CustomButton(
                    onTap: () {
                      final String _selectedDate =
                          DateFormat('yyyy-MM-dd').format(DateTime.now());
                      print(notesController.text);
                      print(_dateController.text);
                      GetInvoiceIdModel invoicesModel = GetInvoiceIdModel(
                          id: 0,
                          uuid: '0',
                          bondSerial: 0,
                          transactionNo: 1,
                          accountName: 'Hasan',
                          notes: notesController.text ?? '',
                          transactionDate: _dateController.text == ''
                              ? _selectedDate
                              : _dateController.text,
                          purchaseOrderNumber: '',
                          invoiceTypeId: 2,
                          accountBranchId: 0,
                          branchId: 1,
                          batchId: 7,
                          departmentId: 1,
                          accountId: 3886,
                          storeId: getSalesman()!.storeId,
                          fromStoreId: getSalesman()!.storeId,
                          toStoreId: id,
                          salesmanId: getSalesman()!.id,
                          taxTypeId: 0,
                          source: 'mobile',
                          totalBeforeTax: 212,
                          tax: 2,
                          discount: 2,
                          totalAfterTax: 21,
                          totalChecks: 0,
                          userId: getUser()!.id,
                          createdAt: _selectedDate,
                          inventoryTransactionItems:
                              inventoryTransactionItemsList);

                      if (inventoryTransactionItemsList.isNotEmpty &&
                          id != null) {
                        TransferCubit().createTransfer(invoicesModel);
                      } else {
                        Get.snackbar('Portfolio Financial System'.tr,
                            'Please fill all fields'.tr,
                            backgroundColor: CupertinoColors.white,
                            colorText: Constants.primaryColor);
                      }
                    },
                    text: widget.invoicesModel != null
                        ? widget.invoicesModel!.toStoreId ==
                                getSalesman()!.storeId
                            ? 'Confirmation'.tr
                            : 'Confirmation'.tr
                        : 'Confirmation'.tr,
                  ))
                ],
              ),
            ));
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
                        setState(() {
                          qController.text =
                              inventoryTransactionItemsList[index]
                                  .quantity
                                  .toString();
                        });
                        if (widget.invoicesModel == null) {
                          buildBottomSheet(
                              inventoryTransactionItemsList[index]);
                        } else {
                          if (widget.invoicesModel!.toStoreId ==
                                  getSalesman()!.storeId ||
                              widget.invoicesModel!.statusId == 2) {
                            return;
                          } else {
                            buildBottomSheet(
                                inventoryTransactionItemsList[index]);
                          }
                        }
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
