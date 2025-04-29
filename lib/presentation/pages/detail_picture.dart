import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
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
                    padding:
                        const EdgeInsets.only(left: 16, bottom: 4, top: 14, right: 16),
                    child: Text(
                      data.story.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8, right: 16),
                    child: Text(
                      data.story.createdAt.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
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
}
