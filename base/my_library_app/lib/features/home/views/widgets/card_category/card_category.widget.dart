import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../shared/entities/category.entity.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../contents/views/contents.page.dart';

class CardCategory extends StatelessWidget {
  final Category category;
  const CardCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return SizedBox(
      height: 120,
      child: Card(
        elevation: 10,
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
                ? LinearGradient(
                    colors: [
                      appColors.primaryColor!,
                      appColors.secondaryColor!,
                    ],
                  )
                : null,
          ),
          child: InkWell(
            splashColor: appColors.secondaryColor!.withOpacity(.6),
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
