import 'package:firstprojects/view/screens/customers/account_statement/account_statement_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/cubit/customer_cubit/customer_cubit.dart';
import '../../../../controllers/cubit/customer_cubit/customer_state.dart';
import '../../../../models/Customers/customer_id_model.dart';
import '../../../../models/account_statment_model/bonds_initialize_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/date_entry_field.dart';
import '../../../widgets/app_bar_widget/rounded_app_bar.dart';
import '../../../widgets/selectable_entry_field.dart';
import '../../lost_connection_screen.dart';

class AccountStatementScreen extends StatefulWidget {
  AccountStatementScreen({
    required this.customerIdModel,
  });

  CustomerIdModel customerIdModel;

  @override
  State<AccountStatementScreen> createState() => _State();
}

class _State extends State<AccountStatementScreen> {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  int dID = 1;

  int nId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RoundedAppBar(
          icon: const Icon(Icons.description_outlined),
          title: 'Account statement'.tr,
          subtitle:
              'A statement of account for the customer within a certain period of time and printed'
                  .tr,
        ),
        body: SafeArea(
            child: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return connected
                ? BlocProvider(
                    create: (context) => CustomerCubit()..initializeBond(),
                    child: BlocConsumer<CustomerCubit, CustomerMainState>(
                        listener: (BuildContext context, state) {},
                        builder: (BuildContext context, state) {
                          var data = CustomerCubit.get(context);

                          return state is GetBondsLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(20.r),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 16),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.r),
                                          color: Get.isDarkMode
                                              ? DARK_GREY3
                                              : Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: DateEntryField(
                                                  color: Constants.primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                  filled: true,
                                                  label: 'From the date of'.tr,
                                                  textEditingController:
                                                      startDate,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Expanded(
                                                child: DateEntryField(
                                                  color: Constants.primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                  filled: true,
                                                  label: 'To date'.tr,
                                                  textEditingController:
                                                      endDate,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          SelectableEntryField<Branches>(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.h,
                                                horizontal: 10.w),
                                            label: 'Branch'.tr,
                                            labelWeight: FontWeight.w400,
                                            isCenter: true,
                                            enableOnTab: true,
                                            hasValue: false,
                                            hasBorder: true,
                                            sizeValue: 14.sp,
                                            labelColor: Constants.primaryColor,
                                            valueColor: Get.isDarkMode
                                                ? Colors.white70
                                                : Constants.textColor3,
                                            valueWeight: FontWeight.w400,
                                            items: data.bondsInitializeModel!
                                                .branches!,
                                            textValue: (val) =>
                                                val.nameAr ?? '',
                                            onSelect: (v) {
                                              nId = v.id!;
                                              setState(() {});
                                            },
                                            hint: 'Branch'.tr,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SelectableEntryField<Departments>(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.h,
                                                horizontal: 10.w),
                                            hasValue: false,
                                            label: 'Section'.tr,
                                            labelWeight: FontWeight.w400,
                                            labelColor: Constants.primaryColor,
                                            hint: 'Section'.tr,
                                            hasBorder: true,
                                            valueColor: Get.isDarkMode
                                                ? Colors.white70
                                                : Constants.textColor3,
                                            valueWeight: FontWeight.w400,
                                            sizeValue: 14.sp,
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            items: data.bondsInitializeModel!
                                                .departments!,
                                            textValue: (val) =>
                                                Get.locale!.languageCode == 'ar'
                                                    ? val.nameAr ?? ''
                                                    : val.nameEn ?? '',
                                            onSelect: (v) {
                                              dID = v.id!;
                                              setState(() {});
                                            },
                                            enableOnTab: true,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: CustomButton(
                                              onTap: () {
                                                CustomerCubit()
                                                    .getBonds(
                                                        dID.toString(),
                                                        nId.toString(),
                                                        startDate.text,
                                                        endDate.text,
                                                        widget
                                                            .customerIdModel.id!
                                                            .toString())
                                                    .then((value) {
                                                  if (value.isNull) {
                                                    Get.defaultDialog(
                                                        title:
                                                            'Portfolio Financial System'
                                                                .tr,
                                                        content: Center(
                                                          child: Text(
                                                              'There are no financial transactions for this customer'
                                                                  .tr),
                                                        ));
                                                  } else {
                                                    Get.to(
                                                      AccountStatementResultSearch(
                                                        bonds: value,
                                                      ),
                                                    );
                                                  }
                                                });
                                              },
                                              text: 'Search'.tr,
                                              textStyle: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: Colors.white),
                                              height: 50.h,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                        }))
                : LostConnectionWidget(connected);
          },
          child: const SizedBox(),
        )));
  }
}
