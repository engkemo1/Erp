import 'dart:async';
import 'package:firstprojects/controllers/cubit/customer_cubit/customer_cubit.dart';
import 'package:firstprojects/controllers/cubit/customer_cubit/customer_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../utils/constants.dart';
import '../../screens/customers/customer_details_screen.dart';
import '../../screens/customers/visit_screen/visit_details_screen.dart';
import '../entry_field_widget.dart';
import 'account_widget.dart';

class CustomerItemWidget extends StatefulWidget {
  CustomerItemWidget({
    Key? key,
    required this.customerController,
    required this.searchTextController,
    this.id,
  }) : super(key: key);
  final CustomerCubit customerController;
  final TextEditingController searchTextController;
  final int? id;

  @override
  State<CustomerItemWidget> createState() => _CustomerItemWidgetState();
}

class _CustomerItemWidgetState extends State<CustomerItemWidget> {
  ScrollController scrollController = ScrollController();
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  int length=10;
  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    CustomerCubit.get(context).getAllCustomers(1);

    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    CustomerCubit().getAllCustomers(1);
    length+=10;
    if(mounted) {
      setState(() {

      });
    }
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1, bottom: 8),

      child: BlocConsumer<CustomerCubit, CustomerMainState>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, state) {
              var data = CustomerCubit.get(context);

              return state is GetCustomerLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        widget.id == null
                            ? GetStorage().read('accountNo') != null
                                ? InkWell(
                                    onTap: () {
                                      Get.to(() => VisitDetailsScreen(
                                            customerIdModel:
                                                data.customerIdModel,
                                          ));
                                    },
                                    child: AccountWidget(
                                      customerIdModel: data.customerIdModel,
                                    ),
                                  )
                                : const SizedBox()
                            : const SizedBox(),
                        EntryField(
                          hasBorder: Get.isDarkMode ? false : true,
                          hint: 'Search here'.tr,
                          filled: true,
                          controller: widget.searchTextController,
                          onChanged: (value) {
                            setState(() {
                              if (widget.searchTextController.text.isNum) {
                                data.addSearchToList2(value);
                              } else {
                                data.addSearchToList(value);
                              }
                            });
                          },
                          tail: widget.searchTextController.text.isEmpty
                              ? const SizedBox()
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.searchTextController.clear();
                                      data.customersSearch.clear();
                                    });
                                  },
                                  icon: const Icon(Icons.clear_outlined)),
                          isCenter: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        data.customersSearch.isEmpty
                            ? widget.searchTextController.text.isEmpty
                                ? Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 18.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Theme.of(context).cardColor),
                                      child: CupertinoScrollbar(
                                          scrollbarOrientation:
                                              ScrollbarOrientation.right,
                                          thickness: 4.0,
                                          thicknessWhileDragging: 10.0,
                                          radius: const Radius.circular(32.0),
                                          controller: scrollController,
                                          child:  SmartRefresher(
                                              enablePullDown: true,
                                              enablePullUp: true,
                                              header: WaterDropHeader(),


                                              controller: _refreshController,
                                              onRefresh: _onRefresh,
                                              onLoading: _onLoading,
                                              child:ListView.separated(

                                            itemCount: data.customers.length <length?data.customers.length:length,
                                            controller: scrollController,
                                            // physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  widget.id != null
                                                      ? Get.back(result: [
                                                          data.customers[index]
                                                              .accountNameAr,
                                                          data.customers[index]
                                                              .id
                                                        ])
                                                      : Get.to(
                                                          CustomerDetailsScreen(
                                                          customer: data
                                                              .customers[index],
                                                        ));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5.h,
                                                      horizontal: 15),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height:
                                                            widget.id == null
                                                                ? 60.h
                                                                : 45.h,
                                                        width: widget.id == null
                                                            ? 60.w
                                                            : 45.h,
                                                        decoration: BoxDecoration(
                                                            color: Constants
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Center(
                                                            child: SvgPicture.asset(
                                                                'assets/images/clients.svg')),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          data.customers[index]
                                                                  .accountNameAr ??
                                                              '',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.grey
                                                                  : Constants
                                                                      .textColor2,
                                                              fontSize:
                                                                  widget.id ==
                                                                          null
                                                                      ? 20.sp
                                                                      : 16.sp),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(
                                              height: 10,
                                              thickness: 0.2,
                                            ),
                                          )),
                                    ),
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
                                        'there are no customers'.tr,
                                        style: TextStyle(
                                            color: Constants.textColor2,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text('Add a customer to your account'.tr,
                                          style: TextStyle(
                                              color: Constants.textColor3,
                                              fontSize: 16.sp)),
                                    ],
                                  )
                            : Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Theme.of(context).cardColor),
                                  child: ListView.separated(
                                    itemCount: data.customersSearch.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.to(CustomerDetailsScreen(
                                            customer:
                                                data.customersSearch[index],
                                          ));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: widget.id == null
                                                    ? 60.h
                                                    : 45.h,
                                                width: widget.id == null
                                                    ? 60.w
                                                    : 45.h,
                                                decoration: BoxDecoration(
                                                    color: Constants
                                                        .primaryColor
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                    child: SvgPicture.asset(
                                                        'assets/images/clients.svg')),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  data.customersSearch[index]
                                                          .accountNameAr ??
                                                      '',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Get.isDarkMode
                                                          ? Colors.grey
                                                          : Colors.blue[900],
                                                      fontSize:
                                                          widget.id == null
                                                              ? 20.sp
                                                              : 16.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                      height: 1,
                                      thickness: 0.2,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    );
            }),

      );
  }
}
