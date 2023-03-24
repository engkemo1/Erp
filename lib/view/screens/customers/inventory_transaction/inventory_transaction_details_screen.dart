import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firstprojects/utils/helpers.dart';
import 'package:firstprojects/view/screens/Items/item_categories_screen.dart';
import 'package:firstprojects/view/screens/customers/inventory_transaction/inventory_transaction.dart';
import 'package:firstprojects/view/screens/offers/add_offer_screen/add_offer_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/cubit/Inventory_cubit/Inventory_cubit.dart';
import '../../../../controllers/cubit/customer_cubit/customer_cubit.dart';
import '../../../../controllers/pdf_services/pdf_service.dart';
import '../../../../models/Customers/customer_id_model.dart';
import '../../../../models/customers/create_customer_model.dart';
import '../../../../models/invoices_model/get_invoice_id_model/get_invoice_id.dart';
import '../../../../models/selected_bottom_sheet_model/PayType.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/storage.dart';
import '../../../widgets/customers/account_widget.dart';
import '../../../widgets/selectable_entry_field.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/default_item_widget.dart';
import 'package:flutter/material.dart';
import '../../pdf_view/invoice_pdf.dart';
import '../visit_screen/visit_details_screen.dart';

class InventoryTransactionDetailsScreen extends StatefulWidget {
  InventoryTransactionDetailsScreen(
      {this.customerIdModel,
      required this.id,
      this.invoiceId,
      this.accountName,
      this.accountNo,
      this.invoicesModel,
      this.customer,
      this.isReport,
      required this.payTypes});

  CustomerIdModel? customerIdModel;
  final int id;
  String? invoiceId;
  String? accountName;
  String? accountNo;
  CreateCustomerModel? customer;
  List<PayType> payTypes;
  bool? isReport;
  GetInvoiceIdModel? invoicesModel;

  @override
  _InventoryTransactionDetailsScreenState createState() =>
      _InventoryTransactionDetailsScreenState();
}

class _InventoryTransactionDetailsScreenState
    extends State<InventoryTransactionDetailsScreen> {
  TextEditingController pController = TextEditingController();
  TextEditingController qController = TextEditingController();
  TextEditingController dController = TextEditingController();
  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  bool isExpanded = false;
  List<PayType> payTypes = [];
  List<InventoryTransactionItems> inventoryTransactionItemsList = [];
  var payment;
  double aSum = 0;
  double bSum = 0;
  double totalTax = 0;
  int totalQ = 0;
  int totalD = 0;
  int payTypeId = 1;
  FocusNode text1FocusNode = FocusNode();
  FocusNode text2FocusNode = FocusNode();
  FocusNode text3FocusNode = FocusNode();
  @override
  void initState() {
    payTypes.addAll(widget.payTypes);
    text1FocusNode.addListener(() {
      if (text1FocusNode.hasFocus) {
        qController.selection =
            TextSelection(baseOffset: 0, extentOffset: qController.text.length);
      }
    });
    text2FocusNode.addListener(() {
      if (text2FocusNode.hasFocus) {
        pController.selection =
            TextSelection(baseOffset: 0, extentOffset: pController.text.length);
      }
    });
    text3FocusNode.addListener(() {
      if (text3FocusNode.hasFocus) {
        dController.selection =
            TextSelection(baseOffset: 0, extentOffset: dController.text.length);
      }
    });
    if (widget.invoicesModel != null) {
      inventoryTransactionItemsList
          .addAll(widget.invoicesModel!.inventoryTransactionItems!);
      notesController.text = widget.invoicesModel!.notes!;
      payTypeId == widget.invoicesModel!.invoiceTypeId;
      payment = Get.locale!.languageCode == 'ar'
          ? widget.invoicesModel!.payType!.nameAr
          : widget.invoicesModel!.payType!.nameEn;
    } else {
      payment = Get.locale!.languageCode == 'ar'
          ? widget.customerIdModel!.accountInfo!.payType!.nameAr
          : widget.customerIdModel!.accountInfo!.payType!.nameEn;
    }

    getData();
    super.initState();
  }

  var customersController = CustomerCubit();
  TextEditingController discountController = TextEditingController();

  DateTime dateTime = DateTime.now();
  bool isConfirm = false;
  GetInvoiceIdModel invoicesModel2 = GetInvoiceIdModel();

  @override
  Widget build(BuildContext context) {
    getDataFromMaterial();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          title: Text(
            _getTitleDetails(),
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                if (widget.isReport == true) {
                  Get.back();
                } else {
                  Get.offAll(InventoryScreen(
                    id: widget.id,
                    customer: widget.customer!,
                    customerIdModel: widget.customerIdModel!,
                  ));
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              )),
          actions:isConfirm==true||widget.invoicesModel!=null
              ? [
                  IconButton(
                      onPressed: () {
                        buildDefaultDialogSelectOption(isConfirm == true
                            ? invoicesModel2
                            : widget.invoicesModel!);
                      },
                      icon: const Icon(
                        Icons.print,
                        color: Constants.textColor2,
                      )),
                  IconButton(
                      onPressed: () async {
                        return await awesomeDialogDelete(context).show();
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ]
              : null,
        ),
        body: WillPopScope(
          onWillPop: () async {
            if (widget.isReport == true) {
              Get.back();
            } else {
              Get.offAll(InventoryScreen(
                id: widget.id,
                customer: widget.customer!,
                customerIdModel: widget.customerIdModel!,
              ));
            }
            return false;
          },
          child: Column(
            children: [
              GetStorage().read('accountNo') != null
                  ? InkWell(
                      onTap: () {
                        Get.to(() => VisitDetailsScreen());
                      },
                      child: AccountWidget(),
                    )
                  : const SizedBox(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: Column(
                            children: [
                              SizedBox(height: 20.h),
                              DefaultItemWidget(
                                width: 50.w,
                                height: 50.h,
                                icon: SvgPicture.asset(
                                    'assets/images/clients.svg'),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.customerIdModel == null
                                          ? widget.accountName!
                                          : widget
                                              .customerIdModel!.accountName!,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Constants.textColor3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${widget.customerIdModel == null ? widget.accountNo! : widget.customerIdModel!.accountNo}',
                                      style: TextStyle(
                                        color: Get.isDarkMode
                                            ? Colors.grey
                                            : Constants.textColor3,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.black12,
                                thickness: 0.2,
                              ),
                              expansionTileWidget(widget.invoicesModel),
                              ListTile(
                                title: Row(
                                  children: [
                                    const Icon(
                                        Icons.insert_drive_file_outlined),
                                    Text(
                                      'Total'.tr,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Constants.textColor3,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                trailing: Text(
                                  (aSum * totalQ).toStringAsFixed(3),
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Constants.primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      inventoryTransactionItemsList.isNotEmpty
                          ? buildList(inventoryTransactionItemsList, context)
                          : empty(),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.r))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: () {
                            showCustomBottomSheet(
                              context,
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Get.to(const ItemCategoriesScreen(
                                        isMaterial: false,
                                      ))!
                                          .then((value) {
                                        if (value != null) {
                                          inventoryTransactionItemsList
                                              .addAll(value);
                                        }

                                        setState(() {});
                                      });
                                    },
                                    leading: SvgPicture.asset(
                                      'assets/images/amount.svg',
                                      color: Get.isDarkMode
                                          ? Colors.blueGrey
                                          : Constants.primaryColor,
                                      height: 30,
                                    ),
                                    title: Text(
                                      'Add item'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Constants.textColor2),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black38,
                                    thickness: 0.2,
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Navigator.pop(context);

                                      Get.to(const AddOffersScreen());
                                    },
                                    leading: Icon(
                                      Icons.local_offer_outlined,
                                      color: Get.isDarkMode
                                          ? Colors.blueGrey
                                          : Constants.primaryColor,
                                      size: 30,
                                    ),
                                    title: Text(
                                      'Add offer'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Constants.textColor2),
                                    ),
                                  )
                                ],
                              ),
                            );
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
                        SizedBox(
                          width: 15.h,
                        ),
                        Expanded(
                          child: CustomButton(
                            onTap: () {
                              String _selectedDate = DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now());

                              invoicesModel2.visitId =
                                  GetStorage().read("visitId");
                              invoicesModel2.salesmanId = widget
                                  .customerIdModel!.accountInfo!.salesmanNo;
                              invoicesModel2.inventoryTransactionItems =
                                  inventoryTransactionItemsList;

                              invoicesModel2.discount = 0;
                              invoicesModel2.paymentTypeId = payTypeId;
                              invoicesModel2.departmentId =
                                  widget.invoicesModel == null
                                      ? 2
                                      : widget.invoicesModel!.departmentId;
                              if (widget.invoicesModel != null) {
                                invoicesModel2.id = widget.invoicesModel!.id;
                                invoicesModel2.uuid =
                                    widget.invoicesModel!.uuid;
                              }
                              invoicesModel2.storeId =
                                  widget.invoicesModel == null
                                      ? 2
                                      : widget.invoicesModel!.storeId;
                              invoicesModel2.creditCardId = widget
                                  .customerIdModel!.accountInfo!.accountId;
                              invoicesModel2.invoiceTypeId = payTypeId;

                              invoicesModel2.accountId = widget
                                  .customerIdModel!.accountInfo!.accountId;
                              invoicesModel2.taxTypeId =
                                  widget.invoicesModel == null
                                      ? 2
                                      : widget.invoicesModel!.taxTypeId;
                              invoicesModel2.purchaseOrderNumber =
                                  widget.invoicesModel == null
                                      ? '21'
                                      : widget
                                          .invoicesModel!.purchaseOrderNumber;
                              invoicesModel2.accountBranchId =
                                  widget.invoicesModel == null
                                      ? 2
                                      : widget.invoicesModel!.accountBranchId;
                              invoicesModel2.totalBeforeTax = bSum;
                              invoicesModel2.totalAfterTax = aSum;
                              invoicesModel2.tax = widget.invoicesModel == null
                                  ? 2
                                  : widget.invoicesModel!.tax;
                              invoicesModel2.totalChecks =
                                  widget.invoicesModel == null
                                      ? inventoryTransactionItemsList.length
                                      : widget.invoicesModel!
                                          .inventoryTransactionItems!.length;
                              invoicesModel2.source =
                                  widget.invoicesModel == null
                                      ? 'mobile'
                                      : widget.invoicesModel!.source;
                              invoicesModel2.transactionNo =
                                  widget.invoicesModel == null
                                      ? 1221
                                      : widget.invoicesModel!.transactionNo;
                              invoicesModel2.accountName =
                                  widget.customerIdModel!.accountName;
                              invoicesModel2.batchId =
                                  widget.invoicesModel == null
                                      ? '21'
                                      : widget.invoicesModel!.batchId;
                              invoicesModel2.branchId =
                                  widget.invoicesModel == null
                                      ? 21
                                      : widget.invoicesModel!.branchId;
                              invoicesModel2.transactionDate =
                                  widget.invoicesModel == null
                                      ? _selectedDate
                                      : widget.invoicesModel!.transactionDate;
                              invoicesModel2.notes =
                                  widget.invoicesModel == null
                                      ? notesController.text
                                      : widget.invoicesModel!.notes;

                              invoicesModel2.bondSerial =
                                  widget.invoicesModel == null
                                      ? 2
                                      : widget.invoicesModel!.bondSerial;
                              invoicesModel2.createdAt = _selectedDate;
                              if (widget.invoicesModel == null) {
                                if (inventoryTransactionItemsList.isNotEmpty) {
                                  InventoryCubit()
                                      .createInventory(
                                          widget.id, invoicesModel2)
                                      .then((value) {
                                    InventoryCubit().getInventoryById(value.uuid, widget.id).then((value) {
                                      invoicesModel2=value;
                                      isConfirm = true;

                                      setState(() {

                                      });
                                    }


                                    );
                                    print(invoicesModel2.inventoryTransactionItems!.length);
                                    setState(() {
                                    });
                                  });
                                } else {
                                  Get.snackbar(
                                      'Portfolio Financial System'.tr,
                                      'There are no materials to be added to the bill'
                                          .tr,
                                      backgroundColor: Colors.white,
                                      colorText: Constants.primaryColor);
                                }
                              } else {
                                InventoryCubit().updateInventory(widget.id,
                                    invoicesModel2, notesController.text);
                              }
                            },
                            text: 'Confirmation'.tr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  String _getTitleDetails() {
    return widget.id == 1
        ? 'Sales bill'.tr.tr
        : widget.id == 2
            ? 'Purchase order'.tr
            : 'Sales returns'.tr;
  }

  Container empty() {
    return Container(
        child: Column(children: [
      const Icon(Icons.add_box_outlined, size: 100),
      const SizedBox(
        height: 10,
      ),
      Text(
        'Add items'.tr,
        style: const TextStyle(color: Constants.primaryColor, fontSize: 20),
      )
    ]));
  }

  Future<dynamic> buildDefaultDialogSelectOption(GetInvoiceIdModel invoice) {
    print(invoice.inventoryTransactionItems!.length);

    return Get.bottomSheet(BottomSheet(
        onClosing: () {},
        builder: (_) {
          return SizedBox(
              height: 160,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                          child: Text('Select Options'.tr,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Constants.primaryColor))),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.picture_as_pdf_rounded,
                                  color: Constants.primaryColor),
                              const SizedBox(
                                width: 9,
                              ),
                              Text('Pdf Export'.tr,
                                  style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                          onTap: () async {
                            getformattedTime(TimeOfDay time) {
                              return '${time.hour}:${time.minute} ${time.period.toString().split('.')[1]}';
                            }

                            TimeOfDay initialTime = TimeOfDay.now();

                            var date =
                                '${DateFormat("yyyy-MM-dd").format(DateTime.now())}  ${getformattedTime(initialTime)}';

                            final pdfFile = await PdfInvoice.generate(
                                customer: widget.customerIdModel!,
                                invoice: invoice,
                                userModel: getUser()!,
                                date: date);
                            PdfApi.openFile(pdfFile);
                          }),
                      const Divider(),
                      InkWell(
                          onTap: () {
                            // handlePrintAction();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.local_print_shop_outlined,
                                  color: Constants.primaryColor),
                              const SizedBox(
                                width: 9,
                              ),
                              Text(
                                'Printer'.tr,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ))
                    ],
                  )));
        }));
  }

  buildList(List<InventoryTransactionItems> inventoryTransactionItems,
      BuildContext context) {
    return Visibility(
      visible: false,
      replacement: ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: Column(
          children: [
            ...List.generate(inventoryTransactionItems.length, (index) {
              var totalP = (inventoryTransactionItems[index].totalBeforeTax! *
                      inventoryTransactionItems[index].discountPercentage!) /
                  100;
              var totalA = (inventoryTransactionItems[index].discountAmount! /
                      inventoryTransactionItems[index].totalBeforeTax!) *
                  100;
              return GestureDetector(
                onTap: () {
                  onTapListDialog(context, index, inventoryTransactionItems);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Get.isDarkMode ? DARK_GREY3 : Colors.white),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: FittedBox(
                                child: Row(children: [
                              Text(
                                '${inventoryTransactionItems[index].itemName ?? ''} - ',
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white70
                                        : Constants.textColor2,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                inventoryTransactionItems[index].itemUnitName ??
                                    '',
                                style: TextStyle(
                                    color: inventoryTransactionItems[index]
                                                .itemUnitId ==
                                            1
                                        ? Colors.green
                                        : inventoryTransactionItems[index]
                                                    .itemUnitId ==
                                                2
                                            ? Colors.blue
                                            : Colors.red,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ]))),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Quantity'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Constants.textColor3,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    inventoryTransactionItems[index]
                                        .quantity
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Constants.primaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Discount'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Constants.textColor3,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    inventoryTransactionItemsList[index]
                                                .discountAmount ==
                                            0
                                        ? '${inventoryTransactionItems[index].discountPercentage!.toStringAsFixed(3)}%'
                                        : '${inventoryTransactionItems[index].discountAmount!.toStringAsFixed(3)}%',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Constants.primaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Price'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Constants.textColor3,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    inventoryTransactionItemsList[index]
                                        .totalBeforeTax!
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Constants.primaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Total'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Constants.textColor3,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    inventoryTransactionItems[index]
                                                    .discountAmount ==
                                                0 ||
                                            inventoryTransactionItems[index]
                                                    .discountAmount ==
                                                null
                                        ? (inventoryTransactionItems[index]
                                                    .totalAfterTax! *
                                                (inventoryTransactionItems[
                                                            index]
                                                        .discountPercentage! /
                                                    100))
                                            .toStringAsFixed(3)
                                        : (100 *
                                                (inventoryTransactionItems[
                                                            index]
                                                        .discountAmount! /
                                                    inventoryTransactionItems[
                                                            index]
                                                        .totalBeforeTax!))
                                            .toStringAsFixed(3),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Constants.primaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        inventoryTransactionItems.length == 1
                            ? const SizedBox()
                            : const Divider(
                                thickness: 0.2,
                              )
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 6),
            Container(
              decoration: const BoxDecoration(
                  color: Constants.textColor2,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Number of items'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        inventoryTransactionItems.length.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'total quantities'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        totalQ.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        (bSum * totalQ).toStringAsFixed(3),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        totalTax.toStringAsFixed(3),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        (aSum * totalQ).toStringAsFixed(3),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'discount value%'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        (totalD / 100 * (bSum * totalQ)).toStringAsFixed(3),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          showCustomBottomSheet(
            context,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Get.to(const ItemCategoriesScreen(
                      isMaterial: false,
                    ));
                  },
                  leading: SvgPicture.asset(
                    'assets/images/amount.svg',
                    color: Get.isDarkMode
                        ? Colors.blueGrey
                        : Constants.primaryColor,
                    height: 30,
                  ),
                  title: Text(
                    'Add item'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode
                            ? Colors.white
                            : Constants.textColor2),
                  ),
                ),
                const Divider(
                  color: Colors.black38,
                  thickness: 0.2,
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.local_offer_outlined,
                    color: Get.isDarkMode
                        ? Colors.blueGrey
                        : Constants.primaryColor,
                    size: 30,
                  ),
                  title: Text(
                    'Add offer'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode
                            ? Colors.white
                            : Constants.textColor2),
                  ),
                )
              ],
            ),
          );
        },
        child: SizedBox(
          height: 150.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.newspaper,
                color: Colors.blueGrey.shade100,
                size: 120.r,
              ),
              Text(
                'You must choose the material'.tr,
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* Bottom cheat for add -> 1 Quantity 2 Price 3Discount */
  Future<dynamic> onTapListDialog(BuildContext context, int index,
      List<InventoryTransactionItems> inventoryTransactionItemsList) {
    int _discountType = 0;

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: 200.h,
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Portfolio Financial System'.tr,
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Get.isDarkMode
                          ? Colors.blueGrey
                          : Constants.textColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  inventoryTransactionItemsList[index].itemName ?? '',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Get.isDarkMode
                          ? Colors.white
                          : Constants.primaryColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          pController.text =
                              inventoryTransactionItemsList[index]
                                  .totalAfterTax
                                  .toString();
                          qController.text =
                              inventoryTransactionItemsList[index]
                                  .quantity
                                  .toString();
                          dController.text =
                              inventoryTransactionItemsList[index]
                                          .discountPercentage ==
                                      0
                                  ? inventoryTransactionItemsList[index]
                                      .discountAmount!
                                      .toString()
                                  : inventoryTransactionItemsList[index]
                                      .discountPercentage!
                                      .toString();
                          setState(() {});
                          Navigator.pop(context);
                          showModalBottomSheet<void>(
                            backgroundColor: Get.isDarkMode
                                ? DARK_GREY3
                                : Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                  child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 500.h,
                                  decoration: BoxDecoration(
                                    color: Get.isDarkMode
                                        ? DARK_GREY3
                                        : Colors.white,
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
                                        inventoryTransactionItemsList[index]
                                                .itemName ??
                                            '',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Get.isDarkMode
                                                ? Colors.white
                                                : Constants.textColor2),
                                      ),
                                      Text(
                                        '${inventoryTransactionItemsList[index].itemNumber} حبة',
                                        style: TextStyle(
                                          color: Get.isDarkMode
                                              ? Colors.blueGrey
                                              : Constants.textColor2,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Divider(
                                        color: Colors.black38,
                                        thickness: 0.2,
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
                                                  width: 0.15.sw,
                                                  child: Text(
                                                    'Quantity'.tr,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Constants
                                                                .primaryColor,
                                                        fontSize: 18.sp),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 0.7.sw,
                                                  height: 50.h,
                                                  child: TextField(
                                                    controller: qController,
                                                    textAlign: TextAlign.center,
                                                    focusNode: text1FocusNode,
                                                    onSubmitted: (value) {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              text2FocusNode);
                                                    },
                                                    style: TextStyle(
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Constants
                                                                .textColor),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                      hintText: 'Quantity'.tr,
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.r))),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.r))),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.r))),
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
                                              thickness: 0.2,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 0.15.sw,
                                                  child: Text(
                                                    'Price'.tr,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Constants
                                                                .primaryColor,
                                                        fontSize: 18.sp),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 0.7.sw,
                                                  height: 50.h,
                                                  child: TextField(
                                                    controller: pController,
                                                    focusNode: text2FocusNode,
                                                    onSubmitted: (value) {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              text3FocusNode);
                                                    },
                                                    style: TextStyle(
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Constants
                                                                .textColor),
                                                    textAlign: TextAlign.center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      hintText: '0.000',
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.r))),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.r))),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.r))),
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
                                              thickness: 0.2,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            StatefulBuilder(
                                                builder: (BuildContext context,
                                                        StateSetter setState) =>
                                                    Row(
                                                      children: <Widget>[
                                                        // Radio Button

                                                        Expanded(
                                                            child:
                                                                RadioListTile(
                                                          value: 0,
                                                          groupValue:
                                                              _discountType,
                                                          onChanged: (int?
                                                                  newValue) =>
                                                              setState(() =>
                                                                  _discountType =
                                                                      newValue!),
                                                          title: FittedBox(
                                                            child: Text(
                                                                'discount percentage'
                                                                    .tr),
                                                          ),
                                                        )),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),

                                                        Expanded(
                                                            child:
                                                                RadioListTile(
                                                          value: 1,
                                                          groupValue:
                                                              _discountType,
                                                          onChanged: (int?
                                                                  newValue) =>
                                                              setState(() =>
                                                                  _discountType =
                                                                      newValue!),
                                                          title: FittedBox(
                                                            child: Text(
                                                              'discount value'
                                                                  .tr,
                                                            ),
                                                          ),
                                                        )),
                                                      ],
                                                    )),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 0.15.sw,
                                                  child: Text(
                                                    'الخصم',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Constants
                                                                .primaryColor,
                                                        fontSize: 18.sp),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 0.7.sw,
                                                  height: 50.h,
                                                  child: TextField(
                                                    controller: dController,
                                                    focusNode: text3FocusNode,
                                                    style: TextStyle(
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Constants
                                                                .textColor),
                                                    textAlign: TextAlign.center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                      hintText: 'Discount'.tr,
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.r))),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.r))),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.r))),
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
                                                  if (qController.text.isNotEmpty &&
                                                      pController
                                                          .text.isNotEmpty &&
                                                      dController
                                                          .text.isNotEmpty) {
                                                    InventoryTransactionItems
                                                        item =
                                                        InventoryTransactionItems();
                                                    setState(() {
                                                      item =
                                                          inventoryTransactionItemsList[
                                                              index];

                                                      item.quantity =
                                                          int.tryParse(
                                                              qController.text);
                                                      item.price = int.tryParse(
                                                          pController.text);
                                                      item.discountAmount =
                                                          _discountType == 1
                                                              ? int.tryParse(
                                                                  dController
                                                                      .text)
                                                              : 0;
                                                      item.discountPercentage =
                                                          _discountType == 0
                                                              ? int.tryParse(
                                                                  dController
                                                                      .text)
                                                              : 0;
                                                    });

                                                    inventoryTransactionItemsList
                                                        .removeAt(index);

                                                    setState(() {
                                                      inventoryTransactionItemsList
                                                          .insert(index, item);
                                                      aSum = 0;
                                                      totalD = 0;
                                                      totalQ = 0;
                                                      for (var element
                                                          in inventoryTransactionItemsList) {
                                                        totalQ = totalQ +
                                                            element.quantity!;
                                                        totalD = totalD +
                                                            element
                                                                .discountPercentage!;
                                                        aSum = aSum +
                                                            element
                                                                .totalAfterTax!;
                                                      }
                                                    });

                                                    dController.clear();
                                                    qController.clear();
                                                    pController.clear();
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                height: 50.h,
                                                width: ScreenUtil().screenWidth,
                                                text: 'Add material'.tr,
                                                textStyle: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                            },
                          );
                        },
                        child: Text(
                          'Modify'.tr,
                          style: const TextStyle(color: Constants.primaryColor),
                        )),
                    TextButton(
                        onPressed: () {
                          inventoryTransactionItemsList.removeAt(index);

                          aSum = 0;

                          inventoryTransactionItemsList.forEach((element) {
                            aSum = aSum + element.totalAfterTax! ?? 0;
                          });

                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Delete'.tr,
                          style: const TextStyle(color: Constants.primaryColor),
                        )),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          pController.clear();
                          dController.clear();
                          qController.clear();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Back'.tr,
                          style: const TextStyle(color: Constants.primaryColor),
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  /* Hide more AND Show more */
  ExpansionTile expansionTileWidget(GetInvoiceIdModel? invoicesModel) {
    return ExpansionTile(
      title: Row(
        children: [
          Text(
            isExpanded ? 'Hide more'.tr : 'Show more'.tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white70 : Constants.textColor2),
          ),
          Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.grey,
          )
        ],
      ),
      trailing: const Icon(
        Icons.more_horiz,
        size: 30,
        color: Colors.grey,
      ),
      onExpansionChanged: (val) {
        isExpanded = val;
        setState(() {});
      },
      childrenPadding: EdgeInsets.symmetric(horizontal: 15.w),
      children: [
        SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: DefaultItemWidget.smallIcon(
                padding: EdgeInsets.zero,
                height: 40.h,
                width: 40.w,
                tail: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    invoicesModel == null
                        ? "_"
                        : invoicesModel.transactionNo.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Constants.primaryColor),
                  ),
                ),
                icon: SvgPicture.asset('assets/images/report.svg',
                    color: Constants.primaryColor),
                title: Text(
                  'Invoice number'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Get.isDarkMode ? Colors.grey : Color(0xff64819f),
                  ),
                ),
              ),
            )),
        const Divider(
          color: Colors.black38,
          thickness: 0.2,
        ),
        SizedBox(
          height: 40,
          child: SelectableEntryField<PayType>(
            padding: const EdgeInsets.symmetric(vertical: 1),
            hasValue: false,
            enableOnTab: widget.customerIdModel!.accountInfo!.paymethodNo == 2
                ? false
                : true,
            hasTitle: false,
            hasBorder: false,
            selected: payment,
            valueWeight: FontWeight.bold,
            items: payTypes,
            hasSize: true,
            isCenter: true,
            onSelect: (val) {
              payTypeId = val.id!;

              setState(() {});
            },
            valueColor:
                Get.isDarkMode ? Colors.white70 : Constants.primaryColor,
            textValue: (val) => Get.locale!.languageCode == 'ar'
                ? val.nameAr ?? ''
                : val.nameEn ?? '',
            icon: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                  color: Color(0xff0c60cb).withOpacity(0.10000000149011612),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Icon(
                  Icons.payments,
                  color: Constants.primaryColor,
                ),
              ),
            ),
            hint: 'Payment method'.tr,
          ),
        ),
        const Divider(
          color: Colors.black38,
          thickness: 0.2,
        ),
        SizedBox(
            height: 40,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: DefaultItemWidget.smallIcon(
                    padding: EdgeInsets.zero,
                    height: 40.h,
                    width: 40.w,
                    icon: const Center(
                      child: Icon(
                        Icons.calendar_month_outlined,
                        color: Constants.primaryColor,
                      ),
                    ),
                    title: Text('Date'.tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Get.isDarkMode
                              ? Colors.grey
                              : Constants.textColor3,
                        )),
                    tail: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.h),
                      child: SizedBox(
                          width: 100,
                          child: Text(
                              invoicesModel == null
                                  ? formatDate(dateTime)
                                  : invoicesModel.transactionDate!,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Get.isDarkMode
                                    ? Colors.white70
                                    : Constants.primaryColor,
                              ),
                              textAlign: TextAlign.center)),
                    )))),
        const Divider(
          color: Colors.black38,
          thickness: 0.2,
        ),
        widget.id == 3
            ? SizedBox(
                height: 40,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: DefaultItemWidget.smallIcon(
                      padding: EdgeInsets.zero,
                      height: 40.h,
                      width: 40.w,
                      icon: const Center(
                        child: Icon(Icons.segment_outlined,
                            color: Constants.primaryColor),
                      ),
                      title: TextFormField(
                        controller: invoiceNumberController..text = '0',
                        decoration: InputDecoration(
                          hintText: 'Enter the sales invoice number'.tr,
                          hintStyle: TextStyle(
                              color: Constants.textColor3, fontSize: 14.sp),
                          border: Get.isDarkMode
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.grey))
                              : InputBorder.none,
                          enabledBorder: Get.isDarkMode
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white12))
                              : InputBorder.none,
                          focusedBorder: Get.isDarkMode
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white12))
                              : InputBorder.none,
                        ),
                      ),
                    )),
              )
            : const SizedBox(),
        widget.id == 3
            ? const Divider(
                color: Colors.black38,
                thickness: 0.2,
              )
            : const SizedBox(),
        widget.id != 2
            ? SizedBox(
                height: 40,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: DefaultItemWidget.smallIcon(
                      padding: EdgeInsets.zero,
                      height: 40.h,
                      width: 40.w,
                      icon: SvgPicture.asset('assets/images/coupon.svg',
                          color: Constants.primaryColor, width: 23),
                      title: TextFormField(
                        controller: discountController
                          ..text = invoicesModel == null
                              ? ""
                              : invoicesModel.discount.toString(),
                        style: const TextStyle(color: Colors.grey),
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (val) {
                          for (var element in inventoryTransactionItemsList) {
                            element.discountPercentage = int.tryParse(val);
                            print(element.discountPercentage);
                          }
                          discountController.text = val;

                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Discount'.tr,
                          hintStyle: TextStyle(
                              color: Constants.textColor3, fontSize: 14.sp),
                          enabledBorder: Get.isDarkMode
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white12))
                              : InputBorder.none,
                          focusedBorder: Get.isDarkMode
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white12))
                              : InputBorder.none,
                        ),
                      ),
                    )))
            : const SizedBox(),
        const SizedBox(
          height: 6,
        ),
        SizedBox(
          height: 60,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: DefaultItemWidget.smallIcon(
                padding: EdgeInsets.zero,
                height: 40.h,
                width: 40.w,
                icon: const Center(
                  child: Icon(Icons.segment_outlined,
                      color: Constants.primaryColor),
                ),
                title: TextFormField(
                  controller: notesController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: 'Add note'.tr,
                    hintStyle:
                        TextStyle(color: Constants.textColor3, fontSize: 14.sp),
                    border: Get.isDarkMode
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.grey))
                        : InputBorder.none,
                    enabledBorder: Get.isDarkMode
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white12))
                        : InputBorder.none,
                    focusedBorder: Get.isDarkMode
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white12))
                        : InputBorder.none,
                  ),
                ),
              )),
        )
      ],
    );
  }

  /* inventrory delete */
  AwesomeDialog awesomeDialogDelete(BuildContext context) {
    return AwesomeDialog(
      dialogBackgroundColor: Get.isDarkMode ? DARK_GREY : Colors.white,
      context: context,
      padding: const EdgeInsets.all(20),
      btnCancel: Row(
        children: [
          InkWell(
            onTap: () {
              if (getUser()!.welcomeUserPermissions!["sales_invoices.delete"] ==
                  true) {
                InventoryCubit()
                    .deleteInventory(widget.invoicesModel!.uuid, widget.id)
                    .then((value) {
                  Get.to(InventoryScreen(
                      customerIdModel: widget.customerIdModel!,
                      customer: widget.customer!,
                      id: widget.id));
                });
              }
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
            'Delete'.tr,
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white70 : Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Are you sure you want to remove item'.tr,
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

  getData() {
    if (widget.invoicesModel != null) {
      aSum = 0;
      widget.invoicesModel!.inventoryTransactionItems!.forEach((element) {
        aSum += element.totalAfterTax!;
      });
      bSum = 0;
      widget.invoicesModel!.inventoryTransactionItems!.forEach((element) {
        bSum += element.totalBeforeTax!;
      });
      totalQ = 0;
      widget.invoicesModel!.inventoryTransactionItems!.forEach((element) {
        totalQ += element.quantity!;
      });
      totalD = 0;
      widget.invoicesModel!.inventoryTransactionItems!.forEach((element) {
        totalD += element.discountPercentage!;
      });
      totalTax = 0;
      widget.invoicesModel!.inventoryTransactionItems!.forEach((element) {
        totalTax += element.taxAmount ?? 0;
      });
    }
  }

  getDataFromMaterial() {
    if (inventoryTransactionItemsList.isNotEmpty) {
      aSum = 0;
      inventoryTransactionItemsList.forEach((element) {
        aSum += element.totalAfterTax ?? 0;
      });
      bSum = 0;
      inventoryTransactionItemsList.forEach((element) {
        bSum += element.totalBeforeTax ?? 0;
      });
      totalQ = 0;
      for (var element in inventoryTransactionItemsList) {
        totalQ += element.quantity ?? 0;
      }
      totalD = 0;
      for (var element in inventoryTransactionItemsList) {
        totalD += element.discountPercentage ?? 0;
      }
      totalTax = 0;
      for (var element in inventoryTransactionItemsList) {
        totalTax += element.taxAmount ?? 0;
      }
      setState(() {});
    }
  }
}
