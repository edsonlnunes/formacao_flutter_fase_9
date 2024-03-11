import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../colors.dart';
import '../../../../../../shared/models/category.model.dart';
import '../../../../../contents/views/contents/contents.page.dart';

class CardCategory extends StatelessWidget {
  final Category category;
  const CardCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        elevation: 10,
        shadowColor: primaryColor,
        child: Container(
          decoration: BoxDecoration(
            image: category.filePath != null
                ? DecorationImage(
                    image: FileImage(File(category.filePath!)),
                    fit: BoxFit.fitWidth,
                    opacity: .6,
                  )
                : null,
            gradient: category.filePath == null
                ? const LinearGradient(
                    colors: [
                      primaryColor,
                      secondaryColor,
                    ],
                  )
                : null,
          ),
          child: InkWell(
            splashColor: secondaryColor.withOpacity(.6),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ContentsPage(category: category),
                ),
              );
            },
            child: Center(
              child: Text(category.name),
            ),
          ),
        ),
      ),
    );
  }
}
