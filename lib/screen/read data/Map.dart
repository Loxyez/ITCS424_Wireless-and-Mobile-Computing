import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype/screen/read data/Map.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(13.754426531790413, 100.43158465028245),
    zoom:  11.5,
  );

  static final Marker _kGlamperMarker = Marker(
    markerId: MarkerId('kGooglePlex'),
    infoWindow: InfoWindow(title: 'Glamper Coffee and Craft Beer'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(13.673354255719174, 100.52493158131863)
  );

  static final Marker _kAnonymousMarker = Marker(
    markerId: MarkerId('kGooglePlex'),
    infoWindow: InfoWindow(title: 'Anonymous Coffee'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(13.747819147551096, 100.57698447116377)
  );

  static final Marker _kFOSHOBROMarker = Marker(
    markerId: MarkerId('kGooglePlex'),
    infoWindow: InfoWindow(title: 'FO SHO BRO'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(13.678392125131893, 100.6011072236463)
  );

  static final Marker _kHOLIDAYMarker = Marker(
    markerId: MarkerId('kGooglePlex'),
    infoWindow: InfoWindow(title: 'HOLIDAY PASTRY Flagship Store'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(13.724841784032701, 100.50516632735398)
  );

  static final Marker _kBASKETMarker = Marker(
    markerId: MarkerId('kGooglePlex'),
    infoWindow: InfoWindow(title: 'BASKET coffee and croissant'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(13.838960856475504, 100.72057874084646)
  );

  static final Marker _kElementMarker = Marker(
    markerId: MarkerId('kGooglePlex'),
    infoWindow: InfoWindow(title: 'In My Element Cafe'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(13.800903340697, 100.45210473713877)
  );

  static final Marker _kChurnMarker = Marker(
    markerId: MarkerId('kGooglePlex'),
    infoWindow: InfoWindow(title: 'Churn Buttery'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(13.742785929065674, 100.74710674084551)
  );

  static final Marker _kPrakaiMarker = Marker(
    markerId: MarkerId('kGooglePlex'),
    infoWindow: InfoWindow(title: 'Prakai Cafe & Cuisine'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(13.798599343683286, 100.74678579481116)
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FindKafe Maps"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        toolbarHeight: 80,
      ),
      body: GoogleMap(
        markers: {_kGlamperMarker,_kAnonymousMarker,_kFOSHOBROMarker,_kHOLIDAYMarker,_kBASKETMarker,_kElementMarker,_kChurnMarker,_kPrakaiMarker},
        
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        ),
    );
  }
}