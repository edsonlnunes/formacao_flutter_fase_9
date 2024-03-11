import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../shared/entities/category.entity.dart';
import '../../../shared/views/widgets/error.modal.dart';
import '../../../themes/app_colors.dart';
import 'contents.store.dart';
import 'widgets/add_content/add_content.widget.dart';
import 'widgets/card_content/card_content.widget.dart';

class ContentsPage extends StatelessWidget {
  final Category category;
  final store = ContentsStore(
    GetIt.I(),
    GetIt.I(),
    GetIt.I(),
  );

  ContentsPage({super.key, required this.category}) {
    store.getContents(category.id);
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo a sua biblioteca'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Conteúdos da categoria: ${category.name}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: appColors.secondaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Observer(
                builder: (context) {
                  return store.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: appColors.primaryColor,
                          ),
                        )
                      : ListView.builder(
                          itemCount: store.contents.length,
                          itemBuilder: (context, index) {
                            final content = store.contents[index];
                            return Dismissible(
                              key: ValueKey(content.id),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) async {
                                await store.removeContent(
                                  contentId: content.id,
                                  categoryId: category.id,
                                );
                                return null;
                              },
                              background: Center(
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  color: Colors.red[100],
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: CircularProgressIndicator(
                                      color: appColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              child: CardContent(
                                content: content,
                                categoryId: category.id,
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final contentName = await showDialog<String>(
            context: context,
            builder: (_) => const AddContent(),
          );

          if (contentName != null) {
            await store.addNewContent(
              contentName: contentName,
              categoryId: category.id,
            );
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Conteúdo'),
        backgroundColor: appColors.primaryColor!.withOpacity(.7),
      ),
    );
  }
}
