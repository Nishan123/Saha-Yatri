import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapBoxView extends StatefulWidget {
  const MapBoxView({super.key});

  @override
  _MapBoxViewState createState() => _MapBoxViewState();
}

class _MapBoxViewState extends State<MapBoxView> {
  final double latitude = 27.7172; // Replace with your latitude
  final double longitude = 85.3240; // Replace with your longitude
  final double zoomLevel = 14.4; // Zoom level (0-22)

  // Create a MapController to control the camera position
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    // Set the initial camera position when the map is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.move(LatLng(latitude, longitude), zoomLevel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26), // Apply border radius here
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          child: FlutterMap(
            mapController: mapController,
            options: const MapOptions(
              maxZoom: 19, // Maximum zoom level
              minZoom: 5, // Minimum zoom level
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibmlzaGFuZ2lyaTIiLCJhIjoiY2xxZjAyMDFnMGs1MDJqbzRkY2h2NmxnMiJ9.wD61vyVq8-siwd4_2Uh-Lw',
                additionalOptions: const {
                  'accessToken':
                      'pk.eyJ1IjoibmlzaGFuZ2lyaTIiLCJhIjoiY2xxZjAyMDFnMGs1MDJqbzRkY2h2NmxnMiJ9.wD61vyVq8-siwd4_2Uh-Lw',
                  'id': 'mapbox/navigation-night-v1',
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
