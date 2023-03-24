import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ToursScreen extends StatefulWidget {
  const ToursScreen({Key? key}) : super(key: key);

  @override
  _ToursScreenState createState() => _ToursScreenState();
}

class _ToursScreenState extends State<ToursScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Tours'.tr,
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
        actions: [
          Center(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Advance visits'.tr,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
          )
        ],
      ),
      body: isLocationDone == false
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
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
              myLocationButtonEnabled: true,
            ),
    );
  }
}
