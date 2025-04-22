import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class DetailPicture extends StatelessWidget {
  const DetailPicture({super.key});

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/noimage.jpg',
            width: double.infinity,
            height: 400,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 4, top: 14),
            child: Text(
              'Yazid bintang',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              '22, April 2025',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Description Lorem ipsum dolor sit amet. Description Lorem ipsum dolor sit amet. Description Lorem ipsum dolor sit amet.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
