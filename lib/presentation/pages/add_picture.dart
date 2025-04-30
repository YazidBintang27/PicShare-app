import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picshare_app/data/remote/models/request/add_story_request.dart';
import 'package:picshare_app/presentation/widgets/button_add_picture.dart';
import 'package:picshare_app/presentation/widgets/button_fill.dart';
import 'package:picshare_app/providers/add_picture/add_picture_provider.dart';
import 'package:picshare_app/providers/main/index_nav_provider.dart';
import 'package:picshare_app/utils/app_state.dart';
import 'package:provider/provider.dart';

class AddPicture extends StatefulWidget {
  const AddPicture({super.key});

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            context.read<IndexNavProvider>().setIndexBottomNavbar = 0;
            context.read<AddPictureProvider>().setImagePath(null);
          },
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
      body: Consumer<AddPictureProvider>(
        builder: (context, provider, child) {
          final isLoading = provider.resultState;
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 300,
                          child:
                              context.watch<AddPictureProvider>().imagePath ==
                                      null
                                  ? Image.asset(
                                      'assets/images/noimage.jpg',
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : _showImage(),
                        ),
                        TextField(
                          maxLines: 10,
                          minLines: 1,
                          controller: _controller,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            hintText: 'Add description ...',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 28),
                          child: Row(
                            children: [
                              Expanded(
                                child: ButtonAddPicture(
                                  icon: HugeIcon(
                                    icon: HugeIcons.strokeRoundedAlbum02,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    size: 20,
                                  ),
                                  label: 'Gallery',
                                  action: () => _onGalleryView(),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ButtonAddPicture(
                                  icon: HugeIcon(
                                    icon: HugeIcons.strokeRoundedCamera02,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    size: 20,
                                  ),
                                  label: 'Camera',
                                  action: () => _onCameraView(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: isLoading is AppLoadingState
                              ? const CircularProgressIndicator()
                              : ButtonFill(
                                  text: 'SHARE', action: () => _postPicture()),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  _postPicture() async {
    final addPictureProvider = context.read<AddPictureProvider>();

    final imagePath = addPictureProvider.imagePath;
    final imageFile = addPictureProvider.imageFile;

    if (imagePath == null || imageFile == null || _controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out image and description')),
      );
      return;
    }

    final photoFile = await addPictureProvider.compressImage(imageFile);

    final data =
        AddStoryRequest(description: _controller.text, photo: photoFile);

    await addPictureProvider.addStory(data);

    if (addPictureProvider.resultState is AppLoadedState) {
      addPictureProvider.setImageFile(null);
      addPictureProvider.setImagePath(null);
      context.read<IndexNavProvider>().setIndexBottomNavbar = 0;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Share picture success')),
      );
      return;
    }
  }

  _onGalleryView() async {
    final provider = context.read<AddPictureProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final provider = context.read<AddPictureProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  Widget _showImage() {
    final imagePath = context.read<AddPictureProvider>().imagePath;

    return kIsWeb
        ? Image.network(
            imagePath.toString(),
            fit: BoxFit.cover,
          )
        : Image.file(File(imagePath.toString()), fit: BoxFit.cover);
  }
}
