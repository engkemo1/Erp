import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';
import '../screens/items/item_categories_screen.dart';


class AddMaterialSheetWidget extends StatelessWidget {
  final bool isMaterial;
  const AddMaterialSheetWidget({

    Key? key, required this.isMaterial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {
            Get.to(ItemCategoriesScreen(
              isMaterial: isMaterial,
            ));
          },
          leading: SvgPicture.asset(
            'assets/images/amount.svg',
            color: Get.isDarkMode
                ? Colors.blueGrey
                : Constants.primaryColor,
            height: 30,
          ),
          title: Text(
            'Add item'.tr,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode
                    ? Colors.white
                    : Constants.textColor2),
          ),
        ),
        const Divider(
          color: Colors.black38,
        ),
        ListTile(
        
          leading: Icon(
            Icons.local_offer_outlined,
            color: Get.isDarkMode
                ? Colors.blueGrey
                : Constants.primaryColor,
            size: 30,
          ),
          title: Text(
            'Add offer'.tr,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode
                    ? Colors.white
                    : Constants.textColor2),
          ),
        )
      ],
    );
  }
}
