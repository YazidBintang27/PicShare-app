import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:picshare_app/data/remote/models/response/story_list.dart';
import 'package:picshare_app/presentation/widgets/picture_card.dart';
import 'package:picshare_app/providers/home/home_provider.dart';
import 'package:picshare_app/utils/app_state.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeProvider>().getStoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PicShare',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 24,
              fontFamily: 'Pacifico',
              fontWeight: FontWeight.normal),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedMapsLocation01,
              color: Theme.of(context).colorScheme.tertiary,
              size: 24,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return switch (provider.resultState) {
              AppLoadingState() => Center(
                  child: const CircularProgressIndicator(),
                ),
              AppLoadedState(response: var data as StoryList) =>
                MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: data.listStory.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => context.push('/detail/${data.listStory[index].id}'),
                          child: PictureCard(
                              imageUrl: data.listStory[index].photoUrl,
                              username: data.listStory[index].name));
                    }),
              AppErrorState() => Center(
                  child: Text('Error'),
                ),
              AppNoneState() => Center(
                  child: Text(''),
                )
            };
          },
        ),
      ),
    );
  }
}
