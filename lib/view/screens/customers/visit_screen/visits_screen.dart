import 'package:firstprojects/controllers/cubit/rep_visits_cubit/rep_visits_state.dart';
import 'package:firstprojects/utils/colors.dart';
import 'package:firstprojects/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/cubit/rep_visits_cubit/rep_visits_cubit.dart';
import '../../../widgets/default_item_widget.dart';
import '../../lost_connection_screen.dart';

class VisitsScreen extends StatelessWidget {
  const VisitsScreen({Key? key, required this.cusomerId}) : super(key: key);
  final String cusomerId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? DARK_GREY3 : Colors.white,
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Color(0xffA1C1E0),
            shadows: [BoxShadow(color: Color(0xffA1C1E0), blurRadius: 5)],
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Advance visits'.tr,
          style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Constants.textColor,
              fontSize: 21,
              fontWeight: FontWeight.bold),
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
              ? BlocProvider(
                  create: (context) =>
                      RepVisitsCubit()..getRepVisitCustomer(cusomerId),
                  child: BlocConsumer<RepVisitsCubit, RepVisitsMainState>(
                      listener: (BuildContext context, state) {},
                      builder: (BuildContext context, state) {
                        var data = RepVisitsCubit.get(context);

                        return state is GetRepVisitLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView(children: [
                                Container(
                                    margin: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Get.isDarkMode
                                            ? DARK_GREY3
                                            : Colors.white),
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var parseDate =
                                          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                              .parse(data.repVisitsModelList[index].createdAt!);
                                          var inputDate = DateTime.parse(parseDate.toString());
                                          var outputFormat = DateFormat('HH:mm yyyy-MM-dd');
                                        var   outputDate = outputFormat.format(inputDate);
                                          return DefaultItemWidget(
                                            height: 45,
                                            width: 45,
                                            onTap: () {},
                                            icon: Icon(
                                              Icons.receipt,
                                              size: 30,
                                              color: Get.isDarkMode
                                                  ? Colors.blueGrey
                                                  : Constants.primaryColor,
                                            ),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  Get.locale!.languageCode ==
                                                          'ar'
                                                      ? data
                                                          .repVisitsModelList[
                                                              index]
                                                          .account!
                                                          .accountNameAr!
                                                      : data
                                                          .repVisitsModelList[
                                                              index]
                                                          .account!
                                                          .accountNameEn!,
                                                  style: TextStyle(
                                                      color: Get.isDarkMode
                                                          ? Colors.white
                                                          : Constants.textColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.date_range,
                                                      color: Constants
                                                          .primaryColor,
                                                      size: 14,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                     outputDate??
                                                          '00:00:00',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .watch_later_outlined,
                                                      size: 14,
                                                      color: Constants
                                                          .primaryColor,
                                                    ),
                                                    Text(
                                                      data
                                                              .repVisitsModelList[
                                                                  index]
                                                              .spentTime ??
                                                          ' 00:00:00',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  data.repVisitsModelList[index]
                                                                  .notes ==
                                                              '' ||
                                                          data
                                                                  .repVisitsModelList[
                                                                      index]
                                                                  .notes ==
                                                              null
                                                      ? 'There is no notes'.tr
                                                      : data
                                                          .repVisitsModelList[
                                                              index]
                                                          .notes!,
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const Divider(
                                              thickness: 0,
                                            ),
                                        itemCount:
                                            data.repVisitsModelList.length)),
                              ]);
                      }))
              : LostConnectionWidget(connected);
        },
        child: const SizedBox(),
      ),
    );
  }
}
