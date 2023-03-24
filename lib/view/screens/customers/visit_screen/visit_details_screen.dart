import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/cubit/rep_visits_cubit/rep_visits_cubit.dart';
import '../../../../controllers/cubit/rep_visits_cubit/rep_visits_state.dart';
import '../../../../models/Customers/customer_id_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/helpers.dart';
import 'package:get_storage/get_storage.dart';
import '../../../bottom_navigation_screen.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/default_item_widget.dart';

class VisitDetailsScreen extends StatefulWidget {
  CustomerIdModel? customerIdModel;

  VisitDetailsScreen({this.customerIdModel});

  @override
  _VisitDetailsScreenState createState() => _VisitDetailsScreenState();
}

class _VisitDetailsScreenState extends State<VisitDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
  }

  TextEditingController notesController = TextEditingController();

  File? file;

  @override
  Widget build(BuildContext context) {
    var date2 = DateTime.now();
    DateTime date1 = DateFormat("yyyy-MM-dd hh:mm:ss").parse(
        GetStorage().read('createdAt') ??
            DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()));

    Duration diff = date2.difference(date1);

    String sDuration =
        "${diff.inHours}:${diff.inMinutes.remainder(60)}:${(diff.inSeconds.remainder(60))}";

    return Scaffold(
      appBar: AppBar(
        //   backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Text(
          'visit details'.tr,
          style: const TextStyle(
              //color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Get.isDarkMode ? DARK_GREY3 : Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Column(
                children: [
                  DefaultItemWidget(
                    icon: SvgPicture.asset('assets/images/clients.svg'),
                    width: 55.w,
                    height: 55.h,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          GetStorage().read('visitName') ?? '',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Get.isDarkMode
                                ? Colors.white54
                                : Constants.textColor2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 5,
                    indent: 12,
                    endIndent: 12,
                  ),
                  DefaultItemWidget.smallIcon(
                    height: 40,
                    width: 40,
                    iconPadding: const EdgeInsets.all(6),
                    title: Text(
                      'Date'.tr,
                      style: TextStyle(
                        color:
                            Get.isDarkMode ? Colors.grey : Constants.textColor3,
                        fontSize: 16.sp,
                      ),
                    ),
                    icon: const Icon(Icons.calendar_month_outlined,
                        color: Constants.primaryColor, size: 30),
                    tail: Text(
                      formatDate(DateTime.now()),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode
                            ? Colors.white70
                            : Constants.primaryColor,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DefaultItemWidget.smallIcon(
                    height: 40,
                    width: 40,
                    iconPadding: const EdgeInsets.all(6),
                    title: Text(
                      'duration of visit'.tr,
                      style: TextStyle(
                        color:
                            Get.isDarkMode ? Colors.grey : Constants.textColor3,
                        fontSize: 16.sp,
                      ),
                    ),
                    icon: const Icon(Icons.calendar_month_outlined,
                        color: Constants.primaryColor, size: 30),
                    tail: Center(
                      child: Text(
                        sDuration,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Get.isDarkMode
                              ? Colors.white70
                              : Constants.primaryColor,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DefaultItemWidget.smallIcon(
                    height: 40,
                    width: 40,
                    iconPadding: const EdgeInsets.all(6),
                    title: Text(
                      'number of moves'.tr,
                      style: TextStyle(
                        color:
                            Get.isDarkMode ? Colors.grey : Constants.textColor3,
                        fontSize: 16.sp,
                      ),
                    ),
                    icon: const Icon(
                      Icons.receipt_outlined,
                      color: Constants.primaryColor,
                      size: 30,
                    ),
                    tail: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: Text(
                          '0',
                          style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.white70
                                : Constants.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  DefaultItemWidget.smallIcon(
                    height: 40,
                    width: 40,
                    title: Text(
                      'cash collection'.tr,
                      style: TextStyle(
                        color:
                            Get.isDarkMode ? Colors.grey : Constants.textColor3,
                        fontSize: 16.sp,
                      ),
                    ),
                    icon: SvgPicture.asset('assets/images/wallet.svg'),
                    tail: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: Text(
                          '0',
                          style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.white70
                                : Constants.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).cardColor),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notes'.tr,
                    style: const TextStyle(
                      fontSize: 18, //color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    controller: notesController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Get.isDarkMode
                                    ? Colors.grey.shade700
                                    : Colors.grey,
                                width: 0.1)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Get.isDarkMode
                                    ? Colors.grey.shade700
                                    : Colors.grey,
                                width: 0.1)),
                        hintText: 'Write the following notes'.tr,
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 14.sp)),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).cardColor),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'attachments'.tr,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          setState(() {
                            file = File(result.files.single.path!);
                          });
                        } else {
                          setState(() {});
                          // User canceled the picker
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: .1),
                              color: Get.isDarkMode
                                  ? Colors.grey.shade700
                                  : Colors.white),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      file = null;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.grey,
                                  )),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    file == null
                                        ? 'attached'.tr
                                        : file!.path.split('/').last,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles();

                                    if (result != null) {
                                      setState(() {
                                        file = File(result.files.single.path!);
                                      });
                                    } else {
                                      setState(() {});
                                      // User canceled the picker
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.attachment,
                                    color: Colors.grey,
                                  )),
                            ],
                          )))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    onTap: () {
                      if (notesController.text.isNotEmpty) {
                        RepVisitsCubit().closeVisit(notesController.text,
                            file == null ? null : file!.path);
                      } else {
                        Get.snackbar('Portfolio Financial System'.tr,
                            'notes is not allowed to be empty'.tr,
                            backgroundColor: Colors.white,
                            colorText: Constants.primaryColor);
                      }
                    },
                    height: 60.h,
                    width: 50.w,
                    text: 'Tour confirmation'.tr,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomButton(
                    height: 60.h,
                    width: 50.w,
                    onTap: () {
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.r),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return Container(
                              height: 600,
                              decoration: BoxDecoration(
                                color:
                                    Get.isDarkMode ? DARK_GREY3 : Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.r),
                                ),
                              ),
                              child: BlocProvider(
                                  create: (context) => RepVisitsCubit()
                                    ..getRepVisitReasonsCancellation(),
                                  child:
                                      BlocConsumer<RepVisitsCubit,
                                              RepVisitsMainState>(
                                          listener:
                                              (BuildContext context, state) {},
                                          builder:
                                              (BuildContext context, state) {
                                            var data =
                                                RepVisitsCubit.get(context);

                                            return state
                                                    is GetRepVisitReasonsLoadingState
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Column(
                                                    children: <Widget>[
                                                      ...List.generate(
                                                          data.visitReasonsCancellationList
                                                              .length,
                                                          (index) => Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  DefaultItemWidget(
                                                                    height: 33,
                                                                    width: 33,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            15),
                                                                    onTap: () {
                                                                      RepVisitsCubit()
                                                                          .cancelVisit(data
                                                                              .visitReasonsCancellationList[index]
                                                                              .id
                                                                              .toString())
                                                                          .then((value) {
                                                                        GetStorage().write(
                                                                            "isVisit",
                                                                            false);
                                                                        GetStorage()
                                                                            .remove("visitName");
                                                                        GetStorage()
                                                                            .remove("createdAt");
                                                                        setState(
                                                                            () {});

                                                                        Get.to(
                                                                            BottomNavigationScreen(
                                                                          index:
                                                                              0,
                                                                        ));
                                                                      });
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .segment_outlined,
                                                                        color: Colors
                                                                            .blue),
                                                                    title:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const SizedBox(
                                                                            width:
                                                                                18),
                                                                        Text(
                                                                          Get.locale!.languageCode == 'ar'
                                                                              ? data.visitReasonsCancellationList[index].nameAr.toString()
                                                                              : data.visitReasonsCancellationList[index].nameEn.toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            color: Get.isDarkMode
                                                                                ? Colors.grey.shade300
                                                                                : Colors.blue[900],
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Divider(
                                                                    color: Colors
                                                                            .grey[
                                                                        200],
                                                                    indent: 10,
                                                                    endIndent:
                                                                        10,
                                                                  ),
                                                                ],
                                                              )),
                                                    ],
                                                  );
                                          })));
                        },
                      );
                    },
                    text: 'cancel tour'.tr,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
