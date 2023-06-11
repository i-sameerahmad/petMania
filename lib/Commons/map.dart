// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  Future<LocationData?> _currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    Location location = Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    return await location.getLocation();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<LocationData?>(
            future: _currentLocation(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
              if (snapchat.hasData) {
                final LocationData currentLocation = snapchat.data;
                return SfMaps(
                  layers: [
                    MapTileLayer(
                      initialFocalLatLng: MapLatLng(currentLocation.latitude!,
                          currentLocation.longitude!),
                      initialZoomLevel: 15,
                      initialMarkersCount: 1,
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      markerBuilder: (BuildContext context, int index) {
                        return MapMarker(
                          latitude: currentLocation.latitude!,
                          longitude: currentLocation.longitude!,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red[800],
                          ),
                          size: Size(20, 20),
                        );
                      },
                    ),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(size: 25, Icons.arrow_back)),
          ),
        ],
      ),
    );
  }
}
