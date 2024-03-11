import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../colors.dart';
import '../../../../shared/models/category.model.dart';
import '../../../../shared/views/error.modal.dart';
import 'contents.store.dart';
import 'widgets/add_content/add_content.widget.dart';
import 'widgets/card_content/card_content.widget.dart';

class ContentsPage extends StatefulWidget {
  final Category category;

  const ContentsPage({super.key, required this.category});

  @override
  State<ContentsPage> createState() => _ContentsPageState();
}

class _ContentsPageState extends State<ContentsPage> {
  final store = ContentsStore();

  @override
  void initState() {
    super.initState();
    store.getContents(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bem-vindo a sua biblioteca"),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Conteúdos da categoria: ${widget.category.name}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: secondaryColor,
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
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : ListView.builder(
                          itemCount: store.contents.length,
                          itemBuilder: (context, index) {
                            final content = store.contents[index];
                            return Dismissible(
                              key: ValueKey(content.id),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (_) => removeContent(content.id),
                              background: Center(
                                child: Container(
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
                              child: CardContent(
                                content: content,
                                categoryId: widget.category.id,
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
        onPressed: addContent,
        icon: const Icon(Icons.add),
        label: const Text("Conteúdo"),
        backgroundColor: primaryColor.withOpacity(.7),
      ),
    );
  }

  Future<bool> removeContent(int contentId) async {
    final result = await store.removeContent(
      contentId: contentId,
      categoryId: widget.category.id,
    );

    if (!mounted) return result;

    if (!result) {
      ErrorModal.show(context, store.error!);
    }

    return result;
  }

  Future<void> addContent() async {
    final contentName = await showDialog<String>(
      context: context,
      builder: (_) => const AddContent(),
    );

    if (contentName == null) return;

    final result = await store.addNewContent(
      contentName: contentName,
      categoryId: widget.category.id,
    );

    if (!mounted) return;

    if (!result) {
      ErrorModal.show(context, store.error!);
      return;
    }
  }
}
