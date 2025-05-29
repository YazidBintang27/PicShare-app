import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:picshare_app/data/remote/models/response/story_list.dart';
import 'package:picshare_app/providers/maps/maps_provider.dart';
import 'package:picshare_app/utils/app_state.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late GoogleMapController _googleMapController;
  late final Set<Marker> markers = {};
  final center = const LatLng(-6.8957473, 107.6337669);

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MapsProvider>().getStoryListWithLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MapsProvider>(
        builder: (context, provider, child) {
          return switch (provider.resultState) {
            AppLoadingState() => Center(
                child: const CircularProgressIndicator(),
              ),
            AppLoadedState(response: var data as StoryList) => GoogleMap(
                initialCameraPosition: CameraPosition(target: center, zoom: 5),
                markers: markers,
                onMapCreated: (controller) {
                  _googleMapController = controller;
                  _setMarker(data);
                },
              ),
            AppErrorState() => Center(
                child: Text('Error'),
              ),
            AppNoneState() => Center(
                child: Text(''),
              )
          };
        },
      ),
    );
  }

  Future<void> _setMarker(StoryList data) async {
    for (var marker in data.listStory) {
      LatLng location;
      if (marker.lat != null && marker.lon != null) {
        location = LatLng(marker.lat!, marker.lon!);
      } else {
        location = LatLng(-6.8957473, 107.6337669);
      }
      String address = await _getAddressFromLatLng(marker.lat, marker.lon);
      setState(() {
        markers.add(Marker(
            markerId: MarkerId('Marker: ${marker.name}'),
            position: location,
            infoWindow: InfoWindow(title: marker.name, snippet: address),
            onTap: () {
              _googleMapController
                  .animateCamera(CameraUpdate.newLatLngZoom(location, 18));
            }));
      });
    }
  }

  Future<String> _getAddressFromLatLng(double? lat, double? lon) async {
    if (lat == null || lon == null) {
      return "No Location Available";
    }
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      Placemark place = placemarks.first;
      return '${place.street}, ${place.locality}, ${place.country}';
    } catch (e) {
      debugPrint('$e');
      return "Unknown location";
    }
  }
}
