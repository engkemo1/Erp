import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/app_bar_widget/rounded_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/default_item_widget.dart';
import '../../../widgets/entry_field_widget.dart';
import '../../../widgets/selectable_entry_field.dart';

class AddOffersScreenDetails extends StatefulWidget {
  const AddOffersScreenDetails({Key? key}) : super(key: key);

  @override
  _AddOffersScreenDetailsState createState() => _AddOffersScreenDetailsState();
}

class _AddOffersScreenDetailsState extends State<AddOffersScreenDetails> {
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
                      children: const [
                        Text(
                          'offer1',
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
                    Row(
                      children: [
                        Expanded(
                          child: SelectableEntryField(
                            enableOnTab: false,
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 10.w),
                            onSelect: (val) {},
                            items: list,
                            textValue: (val) => 'نصف العرض',
                            isCenter: false,
                            label: 'Display size'.tr,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: EntryField(
                          label: 'supply quantity'.tr,
                          hint: 'supply quantity'.tr,
                          hintStyle: const TextStyle(fontSize: 14),
                          hasBorder: true,
                        ))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
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
                      children: [
                        Text(
                          'The total quantity:'.tr,
                          style: const TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '2',
                            style: TextStyle(
                                color: Constants.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
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
                      children: [
                        Text(
                          'The total quantity:'.tr,
                          style: const TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '2',
                            style: TextStyle(
                                color: Constants.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ...List.generate(1, (index) => buildDefaultItemWidget())
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
    bool switchValue = false;

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
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
        tail: Switch(
          activeTrackColor: Constants.primaryColor,
          activeColor: Constants.primaryColor,
          value: switchValue,
          thumbColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.black.withOpacity(.48);
            }
            return Colors.white12;
          }),
          onChanged: (value) {
            setState(() {
              switchValue = value;
            });
          },
        ),
      );
    });
  }
}
