import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:picshare_app/data/remote/models/response/story_detail.dart';
import 'package:picshare_app/providers/detail/detail_provider.dart';
import 'package:picshare_app/utils/app_state.dart';
import 'package:provider/provider.dart';

class DetailPicture extends StatefulWidget {
  final String id;
  const DetailPicture({super.key, required this.id});

  @override
  State<DetailPicture> createState() => _DetailPictureState();
}

class _DetailPictureState extends State<DetailPicture> {
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft02,
                color: Theme.of(context).colorScheme.tertiary)),
        title: Text(
          'Detail',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Consumer<DetailProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  onPressed: () {
                    final story = (provider.resultState is AppLoadedState)
                        ? (provider.resultState as AppLoadedState)
                            .response
                            .story
                        : null;
                    if (story?.lat == null || story?.lon == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Unknown location for this picture'),
                        ),
                      );
                    } else {
                      context.push('/maps/detail/${widget.id}');
                    }
                  },
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedMapsLocation01,
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 24,
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Consumer<DetailProvider>(
        builder: (context, provider, child) {
          return switch (provider.resultState) {
            AppLoadingState() => Center(
                child: const CircularProgressIndicator(),
              ),
            AppLoadedState(response: var data as StoryDetail) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    data.story.photoUrl,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, bottom: 4, top: 14, right: 16),
                    child: Text(
                      data.story.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _dateFormat('${data.story.createdAt}'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedLocation01,
                                color: Theme.of(context).colorScheme.tertiary,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: FutureBuilder<String>(
                                  future: getAddressFromLatLng(
                                      data.story.lat, data.story.lon),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Text("Loading...");
                                    } else if (snapshot.hasError) {
                                      return const Text(
                                          "Error loading location");
                                    } else {
                                      return Text(
                                        snapshot.data ?? "No location",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500),
                                      );
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      data.story.description,
                      maxLines: 15,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            AppNoneState() => Center(
                child: Text(''),
              ),
            AppErrorState() => Center(
                child: Text('Error'),
              ),
          };
        },
      ),
    );
  }

  String _dateFormat(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat("EEE, d MMM yyyy", "en_US").format(dateTime);
  }

  Future<String> getAddressFromLatLng(double? lat, double? lon) async {
    if (lat == null || lon == null) {
      return "No Location Available";
    }
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      Placemark place = placemarks.first;

      return "${place.administrativeArea}";
    } catch (e) {
      debugPrint('$e');
      return "Unknown location";
    }
  }
}
