import 'package:firstprojects/controllers/cubit/sales_man_cubit/sales_man_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import 'package:get/get.dart';

import '../../../controllers/cubit/stores_cubit/stores_cubit.dart';
import '../../../controllers/cubit/stores_cubit/stores_state.dart';
import '../../widgets/entry_field_widget.dart';
import '../lost_connection_screen.dart';

class StoresScreenSelectable extends StatefulWidget {
  const StoresScreenSelectable({super.key, required this.isScreen});

  final bool isScreen;

  @override
  _StoresScreenSelectableState createState() => _StoresScreenSelectableState();
}

class _StoresScreenSelectableState extends State<StoresScreenSelectable> {
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
                'stores'.tr,
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
                        create: (context) => StoresCubit()..getStores(),
                        child: BlocConsumer<StoresCubit, StoresMainState>(
                          listener: (BuildContext context, state) {},
                          builder: (BuildContext context, state) {
                            var data = StoresCubit.get(context);

                            return state is GetSalesManLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView(
                                    children: [
                                      EntryField(
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
                                                    data.listStoresSearchModel
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
                                      data.listStoresSearchModel.isEmpty
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
                                                                    .listStoresModel[
                                                                        index]
                                                                    .id,
                                                                data
                                                                    .listStoresModel[
                                                                        index]
                                                                    .person,
                                                                data
                                                                    .listStoresModel[
                                                                        index]
                                                                    .nameAr
                                                              ])
                                                            : null;
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
                                                                vertical: 3,
                                                                horizontal: 15),
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 23,
                                                              backgroundColor:
                                                                  Constants
                                                                      .textColor
                                                                      .withOpacity(
                                                                          0.1),
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                  Icons.store,
                                                                  size: 26,
                                                                  color: Constants
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                '${data.listStoresModel[index].nameAr}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? Colors
                                                                            .grey
                                                                        : Constants
                                                                            .primaryColor,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                  itemCount: data
                                                      .listStoresModel.length)
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/fonts/images/Group 14.png',
                                                      height: 150,
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      'there are no Stores'.tr,
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
                                                        'Add a store to your account'
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
                                                                .listStoresSearchModel[
                                                                    index]
                                                                .id,
                                                            data
                                                                .listStoresSearchModel[
                                                                    index]
                                                                .nameAr
                                                          ])
                                                        : null;
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
                                                        CircleAvatar(
                                                          radius: 23,
                                                          backgroundColor:
                                                              Constants
                                                                  .textColor
                                                                  .withOpacity(
                                                                      0.1),
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.store,
                                                              size: 26,
                                                              color: Constants
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            '${data.listStoresSearchModel[index].nameAr}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Get
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .grey
                                                                    : Constants
                                                                        .primaryColor,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                              itemCount: data
                                                  .listStoresSearchModel.length)
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
