import 'dart:async';
import 'dart:collection';
import 'dart:ffi';

import 'package:agriser_work/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setmap extends StatefulWidget {
  const Setmap({Key? key}) : super(key: key);

  @override
  State<Setmap> createState() => _SetmapState();
}

class _SetmapState extends State<Setmap> {
  late double lat = 0;
  late double long = 0;

  @override
  void initState() {
    super.initState();
    print(lat);
    print(long);
    findLocation();
    print("---------------------------------------------------------------");
    // print(userLocation.latitude);
  }

  Future<Null> findLocation() async {
    LocationData? locationData = await findLocationData();
    setState(() {
      lat = locationData!.latitude!;
      long = locationData.longitude!;
      print("lat = $lat , long = $long");
    });
  }

  Future<LocationData?> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  Container showmap() {
    LatLng latLng = LatLng(lat, long);
    CameraPosition Location_user = CameraPosition(target: latLng, zoom: 17);

    return Container(
      height: 600,
      child: GoogleMap(
        initialCameraPosition: Location_user,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("ตั้งค่าตำแหน่งของคุณ"),
      ),
      body: Container(
        child: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (lat != 0) {
            return showmap();
          }
          return Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}




// SingleChildScrollView(
//         child: Column(children: [
//           showmap(),
//         ]),
//       ),
