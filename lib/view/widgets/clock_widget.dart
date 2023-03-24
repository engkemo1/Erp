import 'dart:async';
import 'package:flutter/material.dart';

class ClockWidget extends StatefulWidget {
  final Widget Function(DateTime) builder;
  const ClockWidget({Key? key, required this.builder}) : super(key: key);

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  late Timer timer;
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Container(child: widget.builder(DateTime.now())));
  }
}
