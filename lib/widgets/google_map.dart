import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatelessWidget {
  final String title;
  final double mapX;
  final double mapY;

  const MapSample({
    Key key,
    @required this.mapX,
    @required this.mapY,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller = Completer();
    LatLng _position = LatLng(mapY, mapX);

    final CameraPosition _cameraPosition = CameraPosition(
      target: _position,
      zoom: 14,
    );

    Set<Marker> _createMarker(){
      return <Marker>[
        Marker(
          markerId: MarkerId(title),
          position: _position,
          draggable: true,
          infoWindow: InfoWindow(title: title)
        ),
      ].toSet();
    }

    return SizedBox(
      width: double.infinity,
      height: 400,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        markers: _createMarker(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

// Future<void> _goToTheLake() async {
//   final GoogleMapController controller = await _controller.future;
//   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// }
}
