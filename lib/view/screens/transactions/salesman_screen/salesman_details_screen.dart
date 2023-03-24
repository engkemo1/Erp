import 'package:firstprojects/controllers/cubit/sales_man_cubit/sales_man_cubit.dart';
import 'package:firstprojects/controllers/cubit/sales_man_cubit/sales_man_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../models/selected_bottom_sheet_model/SalesTypes.dart';
import '../../../../models/transactions_models/sales_men_model/Initialize_sales_model.dart';
import '../../../../models/transactions_models/sales_men_model/sales_representative.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/entry_field_widget.dart';
import '../../../widgets/selectable_entry_field.dart';
import 'salesman_screen.dart';

class SalesmanDetailsScreen extends StatefulWidget {
  const SalesmanDetailsScreen({Key? key, required this.salesMan})
      : super(key: key);
  final SalesRepresentative salesMan;

  @override
  _SalesmanDetailsScreenState createState() => _SalesmanDetailsScreenState();
}

class _SalesmanDetailsScreenState extends State<SalesmanDetailsScreen> {
  final TextEditingController _delegateNameTextEditingController =
      TextEditingController();

  final TextEditingController _delegateAddressTextEditingController =
      TextEditingController();

  final TextEditingController _mobileNoTextEditingController =
      TextEditingController();

  final TextEditingController _agentsDiscountPercentageTextEditingController =
      TextEditingController();
  SalesRepresentative salesManModel = SalesRepresentative();
  int? paymentId, warehouseId, sellingTypeId;
  String? payment, warehouse, sellingType;

  InitializeSalesModel? initializeModel;

  bool isSalesman = false,
      isOrderSalesman = false,
      isCollector = false,
      isWorker = false,
      isDriver = false,
      canEditPrice = false;

  @override
  void initState() {
    super.initState();
    getInit();
  }

  void getInit() {
    SalesManCubit().getInitializeSales().then((value) {
      setState(() {
        initializeModel = value;
      });
      setValues();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          title: Text(
            'Delegate Details'.tr,
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
          child: BlocProvider(
              create: (context) => SalesManCubit()..getInitializeSales(),
              child: BlocConsumer<SalesManCubit, SalesManMainState>(
                  listener: (BuildContext context, state) {},
                  builder: (BuildContext context, state) {
                    var data = SalesManCubit.get(context);

                    return state is GetInitializeSalesLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ListView(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        //  color: Colors.white
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          EntryField(
                                            labelFontWeight: FontWeight.w500,
                                            controller:
                                                _delegateNameTextEditingController,
                                            filled: false,
                                            hasBorder:
                                                Get.isDarkMode ? false : true,
                                            isCenter: false,
                                            hasTitle: true,
                                            hint: 'Delegate Name'.tr,
                                            label: 'Delegate Name'.tr,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          EntryField(
                                            labelFontWeight: FontWeight.w500,
                                            filled: false,
                                            controller:
                                                _mobileNoTextEditingController,
                                            hasBorder:
                                                Get.isDarkMode ? false : true,
                                            isCenter: false,
                                            hasTitle: true,
                                            label: 'Mobile Number'.tr,
                                            hint: 'Mobile Number'.tr,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          EntryField(
                                            labelFontWeight: FontWeight.w500,
                                            controller:
                                                _delegateAddressTextEditingController,
                                            filled: false,
                                            hasBorder:
                                                Get.isDarkMode ? false : true,
                                            isCenter: false,
                                            hasTitle: true,
                                            hint: 'Delegate Address'.tr,
                                            label: 'Delegate Address'.tr,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SelectableEntryField<PayTypes>(
                                            enableOnTab: true,
                                            label: 'Payment method'.tr,
                                            selected: payment,
                                            onSelect: (val) {
                                              setState(() {
                                                paymentId = val.id;
                                              });
                                            },
                                            items: data.initializeModel!
                                                    .payTypes ??
                                                [],
                                            textValue: (val) {
                                              return Get.locale!.languageCode ==
                                                      'ar'
                                                  ? val.nameAr ?? ''
                                                  : val.nameEn ?? '';
                                            },
                                            hint: 'Payment method'.tr,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SelectableEntryField<SalesType>(
                                            labelWeight: FontWeight.w500,
                                            selected: sellingType,
                                            enableOnTab: true,
                                            onSelect: (vl) {
                                              sellingTypeId = vl.id;
                                            },
                                            label: 'Selling Type'.tr,
                                            labelColor: Get.isDarkMode
                                                ? Colors.white
                                                : Constants.textColor2,
                                            items: data.initializeModel!
                                                    .salesTypes ??
                                                [],
                                            textValue: (val) =>
                                                Get.locale!.languageCode == 'ar'
                                                    ? val.nameAr ?? ''
                                                    : val.nameEn ?? '',
                                            hint: 'Selling Type'.tr,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SelectableEntryField<Stores>(
                                            labelWeight: FontWeight.w500,
                                            selected: warehouse,
                                            enableOnTab: true,
                                            onSelect: (val) {
                                              setState(() {
                                                warehouseId = val.id;
                                              });
                                            },
                                            label: 'Warehouse'.tr,
                                            labelColor: Get.isDarkMode
                                                ? Colors.white
                                                : Constants.textColor2,
                                            items:
                                                data.initializeModel!.stores ??
                                                    [],
                                            textValue: (val) =>
                                                val.nameAr ?? '',
                                            hint: 'Warehouse'.tr,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          EntryField(
                                            controller:
                                                _agentsDiscountPercentageTextEditingController,
                                            filled: false,
                                            hasBorder:
                                                Get.isDarkMode ? false : true,
                                            isCenter: false,
                                            hasTitle: true,
                                            hint:
                                                'Agents Discount Percentage'.tr,
                                            label:
                                                'Agents Discount Percentage'.tr,
                                            color: Get.isDarkMode
                                                ? Colors.white
                                                : Constants.textColor2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    _customCheckedBox(),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 50.w),
                                      child: CustomButton(
                                        onTap: () {
                                          _handleUpdateAction();
                                        },
                                        text: 'Confirmation'.tr,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 80.h,
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          );
                  })),
        ));
  }

  void setValues() {
    // if (widget.salesMan.isSalesman != true) {
    setState(() {
      warehouse = widget.salesMan.store == null
          ? ''
          : widget.salesMan.store!.nameAr.toString();
      sellingType = widget.salesMan.salesTypes == null
          ? ''
          : widget.salesMan.salesTypes!.nameAr ?? '';
      payment = widget.salesMan.payTypes == null
          ? ''
          : widget.salesMan.payTypes!.nameAr.toString();

      isSalesman = widget.salesMan.isSalesman!;
      isOrderSalesman = widget.salesMan.isOrderSalesman!;
      isCollector = widget.salesMan.isCollector!;
      isWorker = widget.salesMan.isWorker!;
      isDriver = widget.salesMan.isDriver!;
      canEditPrice = widget.salesMan.canEditPrice!;
      _delegateNameTextEditingController.text = widget.salesMan.name ?? "";
      _delegateAddressTextEditingController.text =
          widget.salesMan.address ?? "";
      _mobileNoTextEditingController.text = widget.salesMan.phone ?? "";
      _agentsDiscountPercentageTextEditingController.text =
          widget.salesMan.salesPonus.toString();
    });
    // }
  }

  Widget _customCheckedBox() {
    return Column(
      children: [
        CheckboxListTile(
          activeColor: Constants.textColor2,
          checkboxShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('Sales Representative'.tr,
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Constants.textColor2,
                  fontWeight: FontWeight.w500)),
          value: isSalesman,
          onChanged: (value) {
            setState(() {
              isSalesman = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          activeColor: Constants.textColor2,
          checkboxShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('Request representative'.tr,
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Constants.textColor2,
                  fontWeight: FontWeight.w500)),
          value: isOrderSalesman,
          onChanged: (value) {
            setState(() {
              isOrderSalesman = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          activeColor: Constants.textColor2,
          checkboxShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('Financial collector'.tr,
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Constants.textColor2,
                  fontWeight: FontWeight.w500)),
          value: isCollector,
          onChanged: (value) {
            setState(() {
              isCollector = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          activeColor: Constants.textColor2,
          checkboxShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('Worker'.tr,
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Constants.textColor2,
                  fontWeight: FontWeight.w500)),
          value: isWorker,
          onChanged: (value) {
            setState(() {
              isWorker = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          activeColor: Constants.textColor2,
          checkboxShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('Driver'.tr,
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Constants.textColor2,
                  fontWeight: FontWeight.w500)),
          value: isDriver,
          onChanged: (value) {
            setState(() {
              isDriver = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          activeColor: Constants.textColor2,
          checkboxShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            'Possibility to adjust the price'.tr,
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Constants.textColor2,
                fontWeight: FontWeight.w500),
          ),
          value: canEditPrice,
          onChanged: (value) {
            setState(() {
              canEditPrice = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        )
      ],
    );
  }

  void _handleUpdateAction() async {
    salesManModel.id = widget.salesMan.id;
    salesManModel.name = _delegateNameTextEditingController.text;
    salesManModel.phone = _mobileNoTextEditingController.text;
    salesManModel.address = _delegateAddressTextEditingController.text;
    salesManModel.salesTypeId = sellingTypeId ?? widget.salesMan.salesTypeId;
    salesManModel.paymentTypeId = paymentId ?? widget.salesMan.paymentTypeId;
    salesManModel.storeId = warehouseId ?? widget.salesMan.storeId;
    salesManModel.collectPonus = 0;
    salesManModel.salesPonus =
        int.tryParse(_agentsDiscountPercentageTextEditingController.text);

    salesManModel.isWorker = isWorker;
    salesManModel.isDriver = isDriver;
    salesManModel.isCollector = isCollector;
    salesManModel.isCollector = isCollector;

    salesManModel.isOrderSalesman = isOrderSalesman;
    salesManModel.isSalesman = isSalesman;
    salesManModel.canEditPrice = canEditPrice;
    SalesManCubit().update(salesManModel).then((value) async {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => const SalesmanScreen(isScreen: true)));

      Get.snackbar(
        'done'.tr,
        'account has been updated!'.tr,
        backgroundColor: Get.isDarkMode ? Colors.white70 : Colors.white,
        colorText: Get.isDarkMode ? Colors.black54 : Colors.black87,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.only(bottom: 50.0),
      );
    });
  }
}
