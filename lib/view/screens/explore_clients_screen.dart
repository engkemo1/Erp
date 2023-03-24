import 'dart:typed_data';
import 'dart:async';
import 'package:firstprojects/controllers/cubit/customer_cubit/customer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class ExploreClientsScreen extends StatefulWidget {
  const ExploreClientsScreen({Key? key}) : super(key: key);

  @override
  _ExploreClientsScreenState createState() => _ExploreClientsScreenState();
}

class _ExploreClientsScreenState extends State<ExploreClientsScreen> {
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  Set<Marker> markers = {};
  Position? currentLocation;
  bool isLocationDone = false;
  marker() async {
    BitmapDescriptor markerBitMap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/icons8-user-location-100.png",
    );


    markers.add(Marker(
        //add first marker
        markerId: MarkerId("1"),
        position: const LatLng(31.945633967, 35.9273480142),

        //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'حسن حموده',
          snippet: '12331',
        ),
        icon: markerBitMap

        //Icon for Marker
        ));
    markers.add(Marker(
        //add first marker
        markerId: MarkerId("1"),
        position: LatLng(currentLocation!.latitude, currentLocation!.longitude),

        //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'حسن حموده',
          snippet: '12331',
        ),
        icon: markerBitMap

        //Icon for Marker
        ));
  }

  _getCurrentLocation() async {
    LocationPermission? permission;
    bool? serviceEnabled;
    isLocationDone = false;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('', 'Location Permission Denied');
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        currentLocation = position;
        print('CURRENT POS: $currentLocation');
        isLocationDone = true;
      });
    }).catchError((e) {
      isLocationDone = true;

      print(e);
    });
  }

  @override
  void initState() {
    _getCurrentLocation();
    // TODO: implement initState
    super.initState();
  }

  // _getLocation() async {
  //   isLocationDone = false;
  //   var location = new Location();
  //   try {
  //     currentLocation = await location.getLocation();
  //
  //     print("locationLatitude: ${currentLocation.latitude}");
  //     print("locationLongitude: ${currentLocation.longitude}");
  //     isLocationDone = true;
  //     setState(
  //             () {}); //rebuild the widget after getting the current location of the user
  //   } on Exception {
  //     isLocationDone = false;
  //     currentLocation = null;
  //   }
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _getLocation();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Discover customers'.tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: isLocationDone == false
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  onTap: (position) {},
                  markers: markers,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentLocation!.latitude, currentLocation!.longitude),
                    zoom: 14.4746,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    this.controller.complete(controller);
                    setState(() {
                      marker();
                    });
                  },
                  zoomControlsEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Text('category'),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
    );
  }
}
