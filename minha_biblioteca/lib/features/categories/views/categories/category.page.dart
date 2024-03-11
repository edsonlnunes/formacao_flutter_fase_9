import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_biblioteca_fase_9/features/authentication/views/login/login.page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../colors.dart';
import '../../../../shared/views/error.modal.dart';
import 'category.store.dart';
import 'widgets/card_category/card_category.widget.dart';
import 'widgets/new_category/new_category.widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final store = CategoryStore();

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  void newCategory(BuildContext ctx) async {
    await showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (ctx) {
        return const NewCategory();
      },
    );

    getCategories();
  }

  Future<void> getCategories() async {
    await store.getCategories();

    if (!mounted) return;

    if (store.error != null) {
      ErrorModal.show(context, store.error!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Bem-vindo a sua biblioteca"),
        actions: [
          IconButton(
            onPressed: () async {
              final sharedPref = await SharedPreferences.getInstance();
              await sharedPref.clear();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => LoginPage()));
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Escolha uma das categorias",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: secondaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Observer(builder: (context) {
                return store.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
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
                              final result =
                                  await store.removeCategory(category.id);

                              if (!mounted) return result;

                              if (!result) {
                                ErrorModal.show(context, store.error!);
                              }

                              return result;
                            },
                            background: Center(
                              child: Container(
                                height: 114,
                                padding: const EdgeInsets.all(20),
                                color: Colors.red[100],
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
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
        backgroundColor: primaryColor.withOpacity(.8),
        label: const Text("+ Categoria"),
      ),
    );
  }
}
