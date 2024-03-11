import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../../shared/entities/content.entity.dart';
import '../../../../../shared/views/widgets/error.modal.dart';
import '../../../../../themes/app_colors.dart';
import 'update_content.store.dart';

class CardContent extends StatelessWidget {
  final Content content;
  final int categoryId;
  final store = UpdateContentStore(GetIt.I());

  CardContent({
    Key? key,
    required this.content,
    required this.categoryId,
  }) : super(key: key) {
    store.setIsChecked(content.isChecked);
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              appColors.primaryColor!.withOpacity(.7),
              appColors.secondaryColor!.withOpacity(.7),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Observer(builder: (_) {
              if (store.failure != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ErrorModal.show(
                    context: context,
                    message: store.failure!,
                    onTap: () => store.clearFailure(),
                  );
                });
              }

              return const SizedBox.shrink();
            }),
            Observer(builder: (_) {
              return store.isLoading
                  ? const LinearProgressIndicator(
                      color: Colors.white,
                    )
                  : const SizedBox();
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(content.name),
                Observer(
                  builder: (context) {
                    return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: store.isLoading
                          ? null
                          : () async {
                              await store.updateIsChecked(
                                categoryId: categoryId,
                                contentId: content.id,
                              );
                            },
                      child: store.isChecked
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.red,
                            ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
