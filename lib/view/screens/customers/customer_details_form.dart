import 'package:firstprojects/controllers/cubit/sales_man_cubit/sales_man_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/selected_bottom_sheet_model/Areas.dart';
import '../../../../models/selected_bottom_sheet_model/Branches.dart';
import '../../../../models/selected_bottom_sheet_model/Currencies.dart';
import '../../../../models/selected_bottom_sheet_model/PayType.dart';
import '../../../../models/selected_bottom_sheet_model/SalesTypes.dart';
import '../../../../models/selected_bottom_sheet_model/sales_men_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../controllers/cubit/customer_cubit/customer_cubit.dart';
import '../../../controllers/cubit/customer_cubit/customer_state.dart';
import '../../../models/Customers/customer_id_model.dart';
import '../../../models/customers/create_customer_model.dart';
import '../../../utils/storage.dart';
import '../../bottom_navigation_screen.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/entry_field_widget.dart';
import '../../widgets/selectable_entry_field.dart';
import 'customer_details_screen.dart';

class CustomerDetailsForm extends StatefulWidget {
  final int? id;

  CustomerDetailsForm(
      {super.key, this.id, this.customerIdModel, this.customer});

  CustomerIdModel? customerIdModel;
  CreateCustomerModel? customer;

  @override
  State<CustomerDetailsForm> createState() => _CustomerDetailsFormState();
}

class _CustomerDetailsFormState extends State<CustomerDetailsForm> {
  CreateCustomerModel customer = CreateCustomerModel();

  final _addClientProvider = CustomerCubit();
  late final TextEditingController _controllerAccountNameAr =
      TextEditingController();
  late final TextEditingController cityController = TextEditingController();
  late final TextEditingController _controllerAccountNameEn =
      TextEditingController();
  late final TextEditingController _contactStaffTextEditingController =
      TextEditingController();
  late final TextEditingController _mobileNoTextEditingController =
      TextEditingController();
  late final TextEditingController _addressTextEditingController =
      TextEditingController();
  late final TextEditingController _emailTextEditingController =
      TextEditingController();
  late final TextEditingController _telephoneNumberEditingController =
      TextEditingController();

  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? payment, currency, salesName, region, branchName, salesType;

  @override
  void initState() {
    super.initState();
    CustomerCubit().initialize().then((value) {
      value.currencies!
          .where((element) => element.coinDefault == true)
          .forEach((element) {
        setState(() {
          customer.coinNo = element.id;
          currency = Get.locale!.languageCode == 'ar'
              ? element.nameAr
              : element.nameEn;
        });
      });
    });
    SalesManCubit()
        .getAll()
        .then((value) => value.firstWhere((element) =>
            element.id == getUser()!.userCompanies!.first.salesmanId!))
        .then((value) {
      salesType = Get.locale!.languageCode == 'ar'
          ? value.salesTypes!.nameAr
          : value.salesTypes!.nameEn;
      salesName = value.name;
      customer.salesmanId = value.id;
      customer.salesTypeId = value.salesTypeId;
      setState(() {});
    });

    if (widget.id != null && widget.id! > 0) {
      getCustomerDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: BlocProvider(
          create: (context) => CustomerCubit()..initialize(),
          child: BlocConsumer<CustomerCubit, CustomerMainState>(
              listener: (BuildContext context, state) {},
              builder: (BuildContext context, state) {
                var data = CustomerCubit.get(context);

                return state is InitializeLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Get.isDarkMode
                                      ? DARK_GREY2
                                      : Colors.white),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    EntryField(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      controller: _controllerAccountNameEn,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return null;
                                        }
                                      },
                                      hasBorder: Get.isDarkMode ? false : true,
                                      filled: false,
                                      isCenter: false,
                                      hasTitle: true,
                                      hint: 'Account Name'.tr,
                                      label: 'Account Name *'.tr,
                                      labelFontWeight: FontWeight.bold,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Constants.textColor,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SelectableEntryField<PayType>(
                                      hasValue: false,
                                      enableOnTab: true,
                                      hasBorder: true,
                                      selected:
                                          widget.id == null ? null : payment,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.h, horizontal: 10.w),
                                      onSelect: (val) {
                                        customer.paymethodNo = val.id;
                                      },
                                      items:
                                          data.initializeModel.payTypes ?? [],
                                      textValue: (val) =>
                                          Get.locale!.languageCode == 'ar'
                                              ? val.nameAr ?? ''
                                              : val.nameEn ?? '',
                                      hint: 'Payment method'.tr,
                                      label: 'Payment method *'.tr,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SelectableEntryField<Currency>(
                                      enableOnTab: false,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.h, horizontal: 10.w),
                                      selected: currency,
                                      onSelect: (val) {
                                        customer.coinNo = val.id;
                                        setState(() {});
                                      },
                                      items:
                                          data.initializeModel.currencies ?? [],
                                      textValue: (val) =>
                                          Get.locale!.languageCode == 'ar'
                                              ? val.nameAr ?? ''
                                              : val.nameEn ?? '',
                                      hint: 'The currency'.tr,
                                      label: 'The currency *'.tr,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SelectableEntryField<Salesman>(
                                      enableOnTab: false,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.h, horizontal: 10.w),
                                      selected: salesName,
                                      onSelect: (val) {
                                        customer.salesmanId = val.id;
                                        setState(() {});
                                      },
                                      items:
                                          data.initializeModel.salesmen ?? [],
                                      textValue: (val) => val.name ?? '',
                                      hint: 'Delegate'.tr,
                                      label: 'Delegate *'.tr,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SelectableEntryField<Area>(
                                      enableOnTab: true,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.h, horizontal: 10.w),
                                      selected:
                                          widget.id == null ? null : region,
                                      onSelect: (val) {
                                        customer.placeNo = val.id;
                                      },
                                      items: data.initializeModel.areas ?? [],
                                      textValue: (val) =>
                                          Get.locale!.languageCode == 'ar'
                                              ? val.nameAr ?? ''
                                              : val.nameEn ?? '',
                                      hint: 'Region'.tr,
                                      label: 'Region *'.tr,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    EntryField(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      filled: false,
                                      controller:
                                          _contactStaffTextEditingController,
                                      hasBorder: Get.isDarkMode ? false : true,
                                      isCenter: false,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return null;
                                        }
                                      },
                                      labelFontWeight: FontWeight.bold,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Constants.textColor,
                                      hasTitle: true,
                                      hint: 'Contact Person'.tr,
                                      label: 'Contact Person *'.tr,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SelectableEntryField<Branch>(
                                      enableOnTab: true,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.h, horizontal: 10.w),
                                      selected:
                                          widget.id == null ? null : branchName,
                                      onSelect: (val) {
                                        customer.branchNo = val.id;
                                      },
                                      items:
                                          data.initializeModel.branches ?? [],
                                      textValue: (val) =>
                                          Get.locale!.languageCode == 'ar'
                                              ? val.nameAr ?? ''
                                              : val.nameEn ?? '',
                                      hint: 'Branch'.tr,
                                      label: 'Branch *'.tr,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    EntryField(
                                      labelFontWeight: FontWeight.bold,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Constants.textColor,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      filled: false,
                                      hasBorder: Get.isDarkMode ? false : true,
                                      controller:
                                          _telephoneNumberEditingController,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return null;
                                        }
                                      },
                                      isCenter: false,
                                      inputType: TextInputType.phone,
                                      hasTitle: true,
                                      hint: 'Telephone number'.tr,
                                      label: 'Telephone number *'.tr,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    EntryField(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      labelFontWeight: FontWeight.bold,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Constants.textColor,
                                      controller:
                                          _mobileNoTextEditingController,
                                      filled: false,
                                      hasBorder: Get.isDarkMode ? false : true,
                                      inputType: TextInputType.phone,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return null;
                                        }
                                      },
                                      isCenter: false,
                                      hasTitle: true,
                                      hint: 'Mobile Number'.tr,
                                      label: 'Mobile Number *'.tr,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    EntryField(
                                      labelFontWeight: FontWeight.bold,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Constants.textColor,
                                      filled: false,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      controller: _addressTextEditingController,
                                      hasBorder: Get.isDarkMode ? false : true,
                                      isCenter: false,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return null;
                                        }
                                      },
                                      hasTitle: true,
                                      hint: 'The address'.tr,
                                      label: 'The address *'.tr,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    EntryField(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      labelFontWeight: FontWeight.bold,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Constants.textColor,
                                      filled: false,
                                      hasBorder: Get.isDarkMode ? false : true,
                                      controller: _emailTextEditingController,
                                      isCenter: false,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return null;
                                        }
                                      },
                                      hasTitle: true,
                                      hint: 'E-mail'.tr,
                                      label: 'E-mail'.tr,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SelectableEntryField<SalesType>(
                                      enableOnTab: false,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.h, horizontal: 10.w),
                                      selected: salesType,
                                      onSelect: (val) {
                                        customer.salesTypeId = val.id;
                                        setState(() {});
                                      },
                                      items:
                                          data.initializeModel.salesTypes ?? [],
                                      textValue: (val) =>
                                          Get.locale!.languageCode == 'ar'
                                              ? val.nameAr ?? ''
                                              : val.nameEn ?? '',
                                      hint: 'Sale Type'.tr,
                                      label: 'Sale Type *'.tr,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.w),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: CustomButton(
                                          onTap: () {
                                            widget.id != null
                                                ? updateCustomerAction()
                                                : createCustomerAction();
                                          },
                                          text: 'Confirmation'.tr,
                                          color: getUser()!
                                                          .welcomeUserPermissions![
                                                      "customers.create"]! ||
                                                  getUser()!
                                                          .welcomeUserPermissions![
                                                      "customers.update"]!
                                              ? null
                                              : Colors.grey,
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
              }),
        ));
  }

  getCustomerDetails() {
    region = Get.locale!.languageCode == 'ar'
        ? widget.customerIdModel!.accountInfo!.area!.nameAr
        : widget.customerIdModel!.accountInfo!.area!.nameEn;
    branchName = Get.locale!.languageCode == 'ar'
        ? widget.customerIdModel!.accountInfo!.branch!.nameAr
        : widget.customerIdModel!.accountInfo!.branch!.nameEn;
    payment = Get.locale!.languageCode == 'ar'
        ? widget.customerIdModel!.accountInfo!.payType!.nameAr
        : widget.customerIdModel!.accountInfo!.payType!.nameEn;

    _controllerAccountNameAr.text = widget.customerIdModel!.accountName ?? "";
    _controllerAccountNameEn.text = widget.customerIdModel!.accountName ?? "";
    _emailTextEditingController.text =
        widget.customerIdModel!.accountInfo!.email ?? "";
    _contactStaffTextEditingController.text =
        widget.customerIdModel!.accountInfo!.contactPerson ?? "";

    _mobileNoTextEditingController.text =
        widget.customerIdModel!.accountInfo!.phoneNo ?? "";
    _telephoneNumberEditingController.text =
        widget.customerIdModel!.accountInfo!.mobileNo ?? "";

    _addressTextEditingController.text =
        widget.customerIdModel!.accountInfo!.address ?? "";
    customer.paymethodNo =
        widget.customerIdModel!.accountInfo!.paymethodNo ?? 0;
    customer.coinNo = widget.customerIdModel!.accountInfo!.coinNo ?? 0;
    customer.salesmanId = widget.customerIdModel!.accountInfo!.salesmanNo ?? 0;
    customer.placeNo = widget.customerIdModel!.accountInfo!.placeNo ?? 0;
    customer.branchNo = widget.customerIdModel!.accountInfo!.branchNo ?? 0;
    customer.salesTypeId = widget.customerIdModel!.accountInfo!.salesTypeId;
    setState(() {});
  }

  updateCustomerAction() async {
    if (getUser()!.welcomeUserPermissions!["customers.update"] == true) {
      setState(() {
        customer.accountName = _controllerAccountNameEn.text;

        customer.accountNameAr = _controllerAccountNameEn.text;
        customer.accountNameEn = _controllerAccountNameEn.text;

        customer.email = _emailTextEditingController.text;
        customer.address = _addressTextEditingController.text;
        customer.mobileNo = _mobileNoTextEditingController.text;

        customer.contactPerson = _contactStaffTextEditingController.text;

        customer.phoneNo = _telephoneNumberEditingController.text;
        customer.id = widget.customerIdModel!.id;
        customer.uuid = widget.customer!.uuid;
      });

      _addClientProvider.updateCustomer(customer, context).then((value) async {
        Navigator.pop(context);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => CustomerDetailsScreen(
                      customer: widget.customer!,
                    )));

        Get.snackbar(
          'done'.tr,
          'account has been updated!'.tr,
          backgroundColor: Get.isDarkMode ? Colors.white70 : Colors.white,
          colorText: Get.isDarkMode ? Colors.black54 : Colors.black87,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 50.0),
        );
      });
    } else {
      Get.snackbar(
        'Portfolio Financial System'.tr,
        'You do not have permission to update the client'.tr,
        backgroundColor: Get.isDarkMode ? Colors.white70 : Colors.white,
        colorText: Get.isDarkMode ? Colors.black54 : Colors.black87,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.only(bottom: 50.0),
      );
    }
  }

  createCustomerAction() async {
    if (getUser()!.welcomeUserPermissions!["customers.create"] == true) {
      setState(() {
        customer.accountName = _controllerAccountNameEn.text;

        customer.accountNameAr = _controllerAccountNameEn.text;
        customer.accountNameEn = _controllerAccountNameEn.text;
        customer.contactPerson = _contactStaffTextEditingController.text;
        customer.email = _emailTextEditingController.text;
        customer.address = _addressTextEditingController.text;
        customer.mobileNo = _mobileNoTextEditingController.text;
        customer.phoneNo = _telephoneNumberEditingController.text;
      });
      if (_controllerAccountNameEn.text.isNotEmpty &&
          _contactStaffTextEditingController.text.isNotEmpty &&
          _mobileNoTextEditingController.text.isNotEmpty &&
          _telephoneNumberEditingController.text.isNotEmpty &&
          _addressTextEditingController.text.isNotEmpty) {
        await _addClientProvider.create(customer).then((value) async {
          Get.to(BottomNavigationScreen(
            index: 1,
          ));

          Get.snackbar(
            'done'.tr,
            'account has been created!'.tr,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.only(bottom: 50.0),
            backgroundColor: Get.isDarkMode ? Colors.white70 : Colors.grey,
            colorText: Get.isDarkMode ? Colors.white : Colors.black,
          );
        }).catchError((onError) {
          Get.snackbar('error'.tr, "$onError",
              colorText: Get.isDarkMode ? Colors.white : Colors.black,
              snackPosition: SnackPosition.TOP);
        });
      } else {
        Get.snackbar(
          'Portfolio Financial System'.tr,
          'Please fill in the fields'.tr,
          backgroundColor: Get.isDarkMode ? Colors.white70 : Colors.white,
          colorText: Get.isDarkMode ? Colors.black54 : Colors.black87,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 50.0),
        );
      }
    } else {
      Get.snackbar(
        'Portfolio Financial System'.tr,
        'You do not have permission to add the customer'.tr,
        backgroundColor: Get.isDarkMode ? Colors.white70 : Colors.white,
        colorText: Get.isDarkMode ? Colors.black54 : Colors.black87,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.only(bottom: 50.0),
      );
    }
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 1,
      centerTitle: true,
      title: Text(
        'Customer details'.tr,
        style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Constants.textColor),
      ),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blueGrey,
            shadows: [BoxShadow(color: Colors.blueGrey, blurRadius: 5)],
          )),
    );
  }
}
