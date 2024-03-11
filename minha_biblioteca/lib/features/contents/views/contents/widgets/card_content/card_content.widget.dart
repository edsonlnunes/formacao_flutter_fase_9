import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../colors.dart';
import '../../../../../../shared/models/content.model.dart';
import '../../../../../../shared/views/error.modal.dart';
import 'update_content.store.dart';

class CardContent extends StatefulWidget {
  final Content content;
  final int categoryId;

  const CardContent({
    Key? key,
    required this.content,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<CardContent> createState() => _CardContentState();
}

class _CardContentState extends State<CardContent> {
  final store = UpdateContentStore();

  @override
  void initState() {
    super.initState();
    store.setIsChecked(widget.content.isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: primaryColor,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor.withOpacity(.7),
              secondaryColor.withOpacity(.7),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
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
                Text(widget.content.name),
                Observer(
                  builder: (context) {
                    return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        foregroundColor: primaryColor,
                      ),
                      onPressed: store.isLoading ? null : updateContent,
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

  Future<void> updateContent() async {
    await store.updateIsChecked(
      categoryId: widget.categoryId,
      contentId: widget.content.id,
    );

    if (!mounted) return;

    if (store.error != null) {
      ErrorModal.show(context, store.error!);
    }
  }
}
