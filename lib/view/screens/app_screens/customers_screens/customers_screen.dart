import 'package:firstprojects/controllers/cubit/customer_cubit/customer_cubit.dart';
import 'package:firstprojects/models/user/user.dart';
import 'package:firstprojects/utils/colors.dart';
import 'package:firstprojects/utils/constants.dart';
import 'package:firstprojects/view/bottom_navigation_screen.dart';
import 'package:firstprojects/view/screens/customers/customer_details_form.dart';
import 'package:firstprojects/view/screens/lost_connection_screen.dart';
import 'package:firstprojects/view/widgets/app_bar_widget/custom_app_bar.dart';
import 'package:firstprojects/view/widgets/customers/customer_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final customerController = CustomerCubit();
  TextEditingController searchTextController = TextEditingController();
  String userJson = GetStorage().read("user");
  UserModel? user;

  @override
  void initState() {
    user = UserModelFromJson(userJson);
    super.initState();
  }

  int i = 1;

  final GlobalKey<_CustomersScreenState> _refreshIndicatorKey =
      GlobalKey<_CustomersScreenState>();

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;

        return connected
            ? Scaffold(
                backgroundColor: Get.isDarkMode ? DARK_GREY2 : null,
                appBar: CustomAppBar(
                  title: 'Customers'.tr,
                ),
                body: WillPopScope(
                    onWillPop: () async {
                      if (widget.id == null) {
                        Get.offAll(BottomNavigationScreen(
                          index: 0,
                        ));
                      } else {
                        Get.back();
                      }
                      return false;
                    },
                    child: CustomerItemWidget(
                          customerController: customerController,
                          searchTextController: searchTextController,
                          id: widget.id,
                        )),
                floatingActionButton: widget.id == 1
                    ? null
                    : user!.welcomeUserPermissions![
                                "additional_education.create"] ??
                            true
                        ? FloatingActionButton(
                            onPressed: () {
                              Get.to(() => CustomerDetailsForm());
                            },
                            backgroundColor: Constants.primaryColor,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox(),
              )
            : LostConnectionWidget(connected);
      },
      child: const SizedBox(),
    );
  }
}
