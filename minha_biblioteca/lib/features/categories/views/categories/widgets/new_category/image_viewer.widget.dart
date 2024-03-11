import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../colors.dart';
import 'add_category.store.dart';

class ImageViewer extends StatelessWidget {
  final AddCategoryStore store;
  final imagePicker = ImagePicker();

  ImageViewer({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final image = await imagePicker.pickImage(source: ImageSource.gallery);

        if (image != null) {
          store.setImage(File(image.path));
        }
      },
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: secondaryColor,
          ),
        ),
        child: Observer(
          builder: (context) {
            return store.imageCategory == null
                ? const Icon(
                    Icons.image,
                    color: primaryColor,
                    size: 50,
                  )
                : Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.file(
                          store.imageCategory!,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: GestureDetector(
                          onTap: store.removeImage,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
