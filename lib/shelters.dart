import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Shelters extends StatefulWidget {
  const Shelters({super.key});

  @override
  State<Shelters> createState() => _SheltersState();
}

class _SheltersState extends State<Shelters> {
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(22.555996, 88.310414), // Example coordinates
          zoom: 15,
        ),
      ),
    );
  }
}
