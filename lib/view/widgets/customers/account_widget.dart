import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../../../models/Customers/customer_id_model.dart';
import '../../../models/customers/create_customer_model.dart';

class AccountWidget extends StatefulWidget {
  AccountWidget({Key? key, this.customerIdModel, this.customer})
      : super(key: key);
  CustomerIdModel? customerIdModel;
  CreateCustomerModel? customer;

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  CountdownTimerController? controller;
  var date2 = DateTime.now();

  DateTime date1 = new DateFormat("yyyy-MM-dd hh:mm:ss")
      .parse(GetStorage().read('createdAt') ?? '2023-04-01 00:00:00');

  Duration diff = Duration();
  StopWatchTimer _stopWatchTimer = StopWatchTimer();

  String? sDuration;
  // Create instance.
  @override
  void initState() {
    diff = date2.difference(date1);
    _stopWatchTimer = StopWatchTimer(
        mode: StopWatchMode.countUp,
        presetMillisecond: diff.inMilliseconds.toInt());
    _stopWatchTimer.onStartTimer();

    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 235, 88, 39),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${GetStorage().read("visitName") ?? ''}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: _stopWatchTimer.rawTime.value,
            builder: (context, snap) {
              final value = snap.data;
              final displayTime =
                  StopWatchTimer.getDisplayTime(value!, milliSecond: false);
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      displayTime,
                      style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
