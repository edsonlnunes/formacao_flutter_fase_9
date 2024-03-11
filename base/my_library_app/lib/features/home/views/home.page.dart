import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:my_library_app/features/settings/views/settings.page.dart';

import '../../../shared/views/widgets/error.modal.dart';
import '../../../themes/app_colors.dart';
import 'home.store.dart';
import 'widgets/card_category/card_category.widget.dart';
import 'widgets/new_category/new_category.widget.dart';

class HomePage extends StatelessWidget {
  final store = HomeStore(GetIt.I(), GetIt.I());

  HomePage({super.key}) {
    GetIt.I.allReady().then((_) => store.getCategories());
  }

  void newCategory(BuildContext ctx) async {
    await showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (ctx) {
        return const NewCategory();
      },
    );

    store.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo a sua biblioteca'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SettingsPage(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
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
                'Escolha uma das categorias',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: appColors.secondaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Observer(builder: (context) {
                return store.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: appColors.primaryColor,
                        ),
                      )
                    : ListView.builder(
                        itemCount: store.categories.length,
                        itemBuilder: (context, index) {
                          final category = store.categories[index];
                          return Dismissible(
                            key: ValueKey(category.id),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              return store.removeCategory(category.id);
                            },
                            background: Center(
                              child: Container(
                                height: 114,
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
                            child: CardCategory(category: category),
                          );
                        },
                      );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => newCategory(context),
        backgroundColor: appColors.primaryColor!.withOpacity(.8),
        label: const Text('+ Categoria'),
      ),
    );
  }
}
