import 'package:flutter/material.dart';

import '../../../../../themes/app_colors.dart';

class AddContent extends StatefulWidget {
  const AddContent({super.key});

  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  final contentController = TextEditingController();

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Novo conteúdo',
              style: TextStyle(
                fontSize: 20,
                color: appColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Nome do conteúdo',
                labelStyle: TextStyle(
                  color: appColors.primaryColor,
                ),
                border: const OutlineInputBorder(),
                
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              color: Colors.black,
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (contentController.text.isNotEmpty) {
                      Navigator.of(context).pop(contentController.text);
                    }
                  },
                  child: const Text('Adicionar'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
