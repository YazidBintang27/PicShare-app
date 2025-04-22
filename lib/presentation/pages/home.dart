import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:picshare_app/presentation/widgets/picture_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
        child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 4,
            itemCount: 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => context.push('/detail'),
                  child: PictureCard(imageUrl: 'test', username: 'test'));
            }),
      ),
    );
  }
}
