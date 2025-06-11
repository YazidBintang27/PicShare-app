import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsAddLocation extends StatefulWidget {
  const MapsAddLocation({super.key});

  @override
  State<MapsAddLocation> createState() => _MapsAddLocationState();
}

class _MapsAddLocationState extends State<MapsAddLocation> {
  LatLng? _pickedLocation;
  GoogleMapController? _mapController;

  void _onTap(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  void _onConfirm() {
    if (_pickedLocation != null) {
      context.pop(_pickedLocation);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please tap to select a location')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location',
            style: Theme.of(context).textTheme.titleSmall),
        actions: [
          TextButton(
            onPressed: _onConfirm,
            child:
                Text('Confirm', style: Theme.of(context).textTheme.titleSmall),
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: (controller) => _mapController = controller,
        initialCameraPosition: const CameraPosition(
          target: LatLng(-6.200000, 106.816666),
          zoom: 12,
        ),
        onTap: _onTap,
        markers: _pickedLocation != null
            ? {
                Marker(
                  markerId: const MarkerId('picked-location'),
                  position: _pickedLocation!,
                ),
              }
            : {},
      ),
    );
  }
}
