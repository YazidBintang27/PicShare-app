import 'package:flutter/material.dart';

class PictureCard extends StatelessWidget {
  final String imageUrl;
  final String username;
  const PictureCard(
      {super.key, required this.imageUrl, required this.username});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            username,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
