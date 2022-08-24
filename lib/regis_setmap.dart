import 'package:agriser_work/utility/allmethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Regis_setmap extends StatefulWidget {
  const Regis_setmap({Key? key}) : super(key: key);

  @override
  State<Regis_setmap> createState() => _Regis_setmapState();
}

class _Regis_setmapState extends State<Regis_setmap> {
  late double lat, long;
  late String load = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (load != "0") {
          return showmap();
        }
        return Center(child: CircularProgressIndicator());
      }),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: RaisedButton(
            color: Allmethod().dartcolor,
            onPressed: () {},
            child: Text(
              "ยืนยัน",
              style: GoogleFonts.mitr(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  //////////////////////////////   MAP     //////////////////////////////////
  Future<Null> findLocation() async {
    LocationData? locationData = await findLocationData();
    setState(() {
      lat = locationData!.latitude!;
      long = locationData.longitude!;
      print("lat = $lat , long = $long");
      load = "1";
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
      height: 300,
      // width: 300,
      child: GoogleMap(
        onTap: (LatLng laalongg) {
          setState(() {
            lat = laalongg.latitude;
            long = laalongg.longitude;
            print("lat = $lat , long = $long");
          });
        },
        initialCameraPosition: Location_user,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: marker(),
      ),
    );
  }

  Marker mylocation() {
    return Marker(
      markerId: MarkerId("asdsadasdasd"),
      position: LatLng(lat, long),
      icon: BitmapDescriptor.defaultMarkerWithHue(1),
    );
  }

  Set<Marker> marker() {
    return <Marker>[mylocation()].toSet();
  }

  ////////////////////////////////////    END   MAP   ///////////////////////////////////////////
}
