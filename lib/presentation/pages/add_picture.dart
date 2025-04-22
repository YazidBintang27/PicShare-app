import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:picshare_app/presentation/widgets/button_add_picture.dart';
import 'package:picshare_app/presentation/widgets/button_fill.dart';
import 'package:picshare_app/providers/main/index_nav_provider.dart';
import 'package:provider/provider.dart';

class AddPicture extends StatelessWidget {
  const AddPicture({super.key});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: true,
    appBar: AppBar(
      leading: IconButton(
        onPressed: () =>
            context.read<IndexNavProvider>().setIndexBottomNavbar = 0,
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedCancel01,
          color: Theme.of(context).colorScheme.tertiary,
          size: 24,
        ),
      ),
      title: Text(
        'Add Picture',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    ),
    body: LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/noimage.jpg',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  TextField(
                    maxLines: 10,
                    minLines: 1,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      hintText: 'Add description ...',
                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.tertiary,
                            width: 0.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
                    child: Row(
                      children: [
                        Expanded(
                          child: ButtonAddPicture(
                            icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedAlbum02,
                              color: Theme.of(context).colorScheme.tertiary,
                              size: 20,
                            ),
                            label: 'Gallery',
                            action: () {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ButtonAddPicture(
                            icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedCamera02,
                              color: Theme.of(context).colorScheme.tertiary,
                              size: 20,
                            ),
                            label: 'Camera',
                            action: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonFill(
                      text: 'SHARE',
                      action: () => context
                          .read<IndexNavProvider>()
                          .setIndexBottomNavbar = 0,
                    ),
                  ),
                  const SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

}
