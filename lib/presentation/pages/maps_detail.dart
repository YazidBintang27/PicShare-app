import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:picshare_app/data/remote/models/response/story.dart';
import 'package:picshare_app/data/remote/models/response/story_detail.dart';
import 'package:picshare_app/providers/detail/detail_provider.dart';
import 'package:picshare_app/utils/app_state.dart';
import 'package:provider/provider.dart';

class MapsDetail extends StatefulWidget {
  final String id;
  const MapsDetail({super.key, required this.id});

  @override
  State<MapsDetail> createState() => _MapsDetailState();
}

class _MapsDetailState extends State<MapsDetail> {
  late GoogleMapController _googleMapController;
  late final Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailProvider>().getStoryDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailProvider>(builder: (context, provider, child) {
        return switch (provider.resultState) {
          AppLoadingState() => Center(
              child: const CircularProgressIndicator(),
            ),
          AppLoadedState(response: var data as StoryDetail) => GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(data.story.lat!, data.story.lon!), zoom: 10),
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
      }),
    );
  }

  Future<void> _setMarker(StoryDetail data) async {
    if (data.story.lat != null && data.story.lon != null) {
      LatLng location = LatLng(data.story.lat!, data.story.lon!);
      String address =
          await _getAddressFromLatLng(location.latitude, location.longitude);
      setState(() {
        markers.add(Marker(
            markerId: MarkerId('Marker: ${data.story.name}'),
            position: location,
            infoWindow: InfoWindow(title: data.story.name, snippet: address),
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
