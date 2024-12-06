import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // Import speed dial

class OnSite extends StatefulWidget {
  const OnSite({super.key});

  @override
  State<OnSite> createState() => _OnSiteState();
}

class _OnSiteState extends State<OnSite> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  List<MapType> mapTypes = [
    MapType.normal,
    MapType.satellite,
    MapType.hybrid,
    MapType.terrain,
    MapType.none
  ];
  int currentMapTypeIndex = 0;

  @override
  void initState() {
    super.initState();
    _locateMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        tiltGesturesEnabled: true,
        fortyFiveDegreeImageryEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,

        mapType: mapTypes[currentMapTypeIndex],
        initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0), // Initial position
            zoom: 0 // Initial zoom level
            ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers, // Use the marker set
      ),
      floatingActionButton: _buildSpeedDial(),
    );
  }

  SpeedDial _buildSpeedDial() {
    return SpeedDial(
      icon: Icons.menu,
      activeIcon: Icons.close,
      spacing: 12,
      spaceBetweenChildren: 12,
      // direction: SpeedDialDirection.down,
      children: [
        SpeedDialChild(
            child: const Icon(Icons.layers),
            label: 'Change Map Type',
            onTap: _changeMapType),
        SpeedDialChild(
            child: const Icon(Icons.location_pin),
            label: 'Go to Location',
            onTap: () => _goToPredefinedLocation(
                const LatLng(27.67393396237352, 85.36994562711988))),
      ],
    );
  }

  Future<void> _locateMe() async {
    final GoogleMapController controller = await _controller.future;
    var position = await _determinePosition();
    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId("currentLocation"),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: "Current Location"),
      ));
    });
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 17.0),
    ));
  }

  Future<void> _goToPredefinedLocation(LatLng location) async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      _markers.removeWhere((m) => m.markerId == const MarkerId("destination"));
      _markers.add(Marker(
        markerId: const MarkerId("destination"),
        position: location,
        infoWindow:
            const InfoWindow(title: "Destination", snippet: "Predefined Location"),
      ));
    });
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: location, zoom: 20.0),
    ));
  }

  void _changeMapType() {
    setState(() {
      currentMapTypeIndex = (currentMapTypeIndex + 1) % mapTypes.length;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
