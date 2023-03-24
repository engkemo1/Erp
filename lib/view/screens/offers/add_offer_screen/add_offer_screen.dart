import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/default_item_widget.dart';
import '../../../widgets/entry_field_widget.dart';
import '../../../widgets/app_bar_widget/rounded_app_bar.dart';
import 'add_offer_screen_details.dart';

class AddOffersScreen extends StatefulWidget {
  const AddOffersScreen({Key? key}) : super(key: key);

  @override
  _AddOffersScreenState createState() => _AddOffersScreenState();
}

class _AddOffersScreenState extends State<AddOffersScreen> {
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
              EntryField(
                hint: 'Search here'.tr,
                isCenter: false,
                filled: true,
                icon: const Icon(Icons.search),
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
                    ...List.generate(2, (index) => buildDefaultItemWidget())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
          onTap: () {},
          height: 60.h,
          width: 250.w,
          text: 'Add offer'.tr,
        ),
      ),
    );
  }

  buildDefaultItemWidget() {
    return DefaultItemWidget(
        onTap: () {
          Get.to(const AddOffersScreenDetails());
        },
        padding: const EdgeInsets.symmetric(vertical: 10),
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
              'offer1'.tr,
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
            Row(
              children: [
                const Icon(
                  Icons.date_range,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  '2022-03-03 - 2022-03-03'.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Get.isDarkMode ? Colors.grey : Constants.textColor3,
                  ),
                ),
              ],
            )
          ],
        ),
        tail: const Icon(Icons.arrow_back_ios_new_outlined));
  }
}
