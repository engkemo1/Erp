import 'package:flutter/material.dart';

LostConnectionWidget(bool connected) {
  return Stack(
    fit: StackFit.expand,
    children: [
      Positioned(
        height: 24.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
          child: Center(
            child: Text("${connected ? 'ONLINE' : 'OFFLINE'}"),
          ),
        ),
      ),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:const [
            Icon(Icons.signal_wifi_connected_no_internet_4_outlined,size: 150,),
            SizedBox(height: 5,),
            Text(
              'Please check your internet',
            ),
          ]
      ),
    ],
  );
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// class LostConnectionScreen extends StatelessWidget {
//   const LostConnectionScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(child: Stack(
//         alignment: Alignment.center,
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: SvgPicture.asset(
//               'assets/images/onboarding4.svg',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             top: MediaQuery.of(context).size.height * 0.3,
//             child:  const Text(
//               'No Internet Connection\nplease check your internet',
//               style: TextStyle(color: Colors.black, fontSize: 25),textAlign: TextAlign.center,
//             ),
//           )
//         ],
//       ),),
//     );
//   }
// }
