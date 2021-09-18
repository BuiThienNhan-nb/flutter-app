import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _googleMapController;
  Set<Marker> _origin = {};
  late Position _currentPosition;
  String destination = 'Da Nang';
  // da nang coordinates

  LatLng daNangPosition = LatLng(16.047079, 108.206230);

  void _locationPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _currentPosition = position;

    CameraPosition _initialCameraPosition =
        CameraPosition(target: (daNangPosition), zoom: 13.0);

    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition));
    // print('${_positionCurrent.latitude} ${_positionCurrent.longitude}');
  }

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   _googleMapController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Future<void> _launchInBrowser(String url) async {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'my_header_key': 'my_header_value'},
        );
      } else {
        throw 'Could not launch $url';
      }
    }

    // onMapCreated(_googleMapController);
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.red),
              margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                // minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                markers: _origin,
                onMapCreated: onMapCreated,
                initialCameraPosition:
                    CameraPosition(target: daNangPosition, zoom: 10.0),
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 10.0,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.navigation,
                  color: Colors.black,
                ),
                onPressed: () => setState(() {
                  _launchInBrowser(
                      "https://www.google.com/maps/dir/?api=1&=&destination=$destination&travelmode=driving");
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onMapCreated(controler) {
    setState(() {
      _googleMapController = controler;
      _origin.add(
        Marker(
            markerId: MarkerId('Danang'),
            position: daNangPosition,
            infoWindow: InfoWindow(title: 'Da Nang city'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
      );

      _locationPosition();
    });
  }
}
