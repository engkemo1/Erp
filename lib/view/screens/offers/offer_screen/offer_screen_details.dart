import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/app_bar_widget/rounded_app_bar.dart';
import '../../../widgets/default_item_widget.dart';

class OfferScreenDetails extends StatefulWidget {
  const OfferScreenDetails({Key? key}) : super(key: key);

  @override
  _OfferScreenDetailsState createState() => _OfferScreenDetailsState();
}

class _OfferScreenDetailsState extends State<OfferScreenDetails> {
  List<String> list = ['حجم 1', 'حجم 3', 'حجم 2'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        icon: const Icon(Icons.local_offer_outlined),
        title: 'Offers'.tr,
        subtitle: 'Show offers with details'.tr,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: ListView(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    'The offer'.tr,
                    style: const TextStyle(
                        color: Constants.textColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Get.isDarkMode ? DARK_GREY2 : Colors.white),
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Group',
                          style: TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.grey[200],
                    ),
                    ...List.generate(2, (index) => buildDefaultItemWidget())
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'bonus'.tr,
                    style: const TextStyle(
                        color: Constants.textColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Get.isDarkMode ? DARK_GREY2 : Colors.white),
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Group3',
                          style: TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.grey[200],
                    ),
                    ...List.generate(1, (index) => buildDefaultItemWidget())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildDefaultItemWidget() {
    return Column(children: [
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return DefaultItemWidget(
          height: 55.h,
          width: 55.w,
          icon: const Icon(
            Icons.local_offer_outlined,
            color: Constants.primaryColor,
            size: 28,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مادة 2 كرتونيه'.tr,
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Constants.textColor2,

                  fontSize: 18.sp,
                  //     color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'الكمية 2'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Get.isDarkMode ? Colors.grey : Constants.textColor3,
                ),
              ),
            ],
          ),
        );
      }),
      Divider(
        color: Colors.grey[200],
      ),
    ]);
  }
}
