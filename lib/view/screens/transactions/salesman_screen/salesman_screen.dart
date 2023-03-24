import 'package:firstprojects/controllers/cubit/sales_man_cubit/sales_man_cubit.dart';
import 'package:firstprojects/controllers/cubit/sales_man_cubit/sales_man_state.dart';
import 'package:firstprojects/view/screens/transactions/salesman_screen/salesman_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/entry_field_widget.dart';
import 'package:get/get.dart';

import '../../lost_connection_screen.dart';

class SalesmanScreen extends StatefulWidget {
  const SalesmanScreen({super.key, required this.isScreen});

  final bool isScreen;

  @override
  _SalesmanScreenState createState() => _SalesmanScreenState();
}

class _SalesmanScreenState extends State<SalesmanScreen> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 70.h),
          child: AppBar(
            backgroundColor: Constants.primaryColor,
            centerTitle: true,
            elevation: 1,
            title: Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Text(
                'Delegates'.tr,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            leading: Padding(
                padding: EdgeInsets.only(top: 15.h),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
                    ))),
          ),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return connected
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocProvider(
                        create: (context) => SalesManCubit()..getAll(),
                        child: BlocConsumer<SalesManCubit, SalesManMainState>(
                          listener: (BuildContext context, state) {},
                          builder: (BuildContext context, state) {
                            var data = SalesManCubit.get(context);

                            return state is GetSalesManLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView(
                                    children: [
                                      EntryField(
                                        margin: true,
                                        hasBorder:
                                            Get.isDarkMode ? false : true,
                                        hint: 'Search here'.tr,
                                        filled: true,
                                        controller: _searchTextController,
                                        onChanged: (value) {
                                          setState(() {
                                            data.addSearchToList(value);
                                          });
                                        },
                                        tail: _searchTextController.text.isEmpty
                                            ? const SizedBox()
                                            : IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _searchTextController
                                                        .clear();
                                                    data.salesmanSearchList
                                                        .clear();
                                                  });
                                                },
                                                icon: const Icon(
                                                    Icons.clear_outlined)),
                                        isCenter: false,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      data.salesmanSearchList.isEmpty
                                          ? _searchTextController.text.isEmpty
                                              ? ListView.separated(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        !widget.isScreen
                                                            ? Get.back(result: [
                                                                data
                                                                    .salesmanList[
                                                                        index]
                                                                    .id,
                                                                data
                                                                    .salesmanList[
                                                                        index]
                                                                    .name
                                                              ])
                                                            : Get.to(
                                                                SalesmanDetailsScreen(
                                                                salesMan:
                                                                    data.salesmanList[
                                                                        index],
                                                              ));
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: Get
                                                                    .isDarkMode
                                                                ? DARK_GREY2
                                                                : Colors.white),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal: 15),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              height:
                                                                  widget.isScreen ==
                                                                          false
                                                                      ? 45.h
                                                                      : 60.h,
                                                              width:
                                                                  widget.isScreen ==
                                                                          false
                                                                      ? 45.w
                                                                      : 60.w,
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
                                                                  child: SvgPicture
                                                                      .asset(
                                                                          'assets/images/clients.svg')),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                '${data.salesmanList[index].name}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? Colors
                                                                            .grey
                                                                        : Constants
                                                                            .textColor2,
                                                                    fontSize: widget.isScreen ==
                                                                            false
                                                                        ? 16.sp
                                                                        : 20.sp),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          SizedBox(
                                                            height:
                                                                widget.isScreen ==
                                                                        false
                                                                    ? 8
                                                                    : 10,
                                                          ),
                                                  itemCount:
                                                      data.salesmanList.length)
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                      'there are no delegates'
                                                          .tr,
                                                      style: TextStyle(
                                                          color: Constants
                                                              .textColor2,
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                        'Add a delegate to your account'
                                                            .tr,
                                                        style: TextStyle(
                                                            color: Constants
                                                                .textColor3,
                                                            fontSize: 16.sp)),
                                                  ],
                                                )
                                          : ListView.separated(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    !widget.isScreen
                                                        ? Get.back(result: [
                                                            data
                                                                .salesmanSearchList[
                                                                    index]
                                                                .id,
                                                            data
                                                                .salesmanSearchList[
                                                                    index]
                                                                .name
                                                          ])
                                                        : Get.to(
                                                            SalesmanDetailsScreen(
                                                            salesMan:
                                                                data.salesmanSearchList[
                                                                    index],
                                                          ));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Get.isDarkMode
                                                            ? DARK_GREY2
                                                            : Colors.white),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10,
                                                        horizontal: 15),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height:
                                                              widget.isScreen ==
                                                                      false
                                                                  ? 45.h
                                                                  : 60.h,
                                                          width:
                                                              widget.isScreen ==
                                                                      false
                                                                  ? 45.w
                                                                  : 60.w,
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
                                                              child: SvgPicture
                                                                  .asset(
                                                                      'assets/images/clients.svg')),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            '${data.salesmanSearchList[index].name}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color: Get
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .grey
                                                                    : Constants
                                                                        .textColor2,
                                                                fontSize:
                                                                    widget.isScreen ==
                                                                            false
                                                                        ? 16.sp
                                                                        : 20.sp),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder: (context,
                                                      index) =>
                                                  SizedBox(
                                                    height:
                                                        widget.isScreen == false
                                                            ? 8
                                                            : 10,
                                                  ),
                                              itemCount: data
                                                  .salesmanSearchList.length)
                                    ],
                                  );
                          },
                        )),
                  )
                : LostConnectionWidget(connected);
          },
          child: const SizedBox(),
        ));
  }
}
