import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../shared/views/widgets/custom_input.widget.dart';
import '../../../shared/views/widgets/error.modal.dart';
import 'add_question.store.dart';

class AddQuestionPage extends StatefulWidget {
  final int deckId;

  const AddQuestionPage({super.key, required this.deckId});

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _askController = TextEditingController();
  final _answerController = TextEditingController();
  final _store = AddQuestionStore(GetIt.I());

  @override
  void dispose() {
    _askController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _addQuestion() async {
    final ask = _askController.text;
    final answer = _answerController.text;

    if (ask.isNotEmpty && answer.isNotEmpty) {
      final question = await _store.addNewQuestion(
        ask: ask,
        answer: answer,
        deckId: widget.deckId,
      );

      if (mounted && question != null) {
        Navigator.of(context).pop(question);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo cartão'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Observer(builder: (_) {
              if (_store.failure != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ErrorModal.show(
                    context: context,
                    message: _store.failure!,
                    onTap: () => _store.clearFailure(),
                  );
                });
              }

              return const SizedBox.shrink();
            }),
            CustomInput(
              controller: _askController,
              label: 'Pergunta',
            ),
            const SizedBox(
              height: 50,
            ),
            CustomInput(
              controller: _answerController,
              label: 'Resposta',
              maxLines: 3,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: 150,
              child: Observer(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: _store.isLoading ? null : _addQuestion,
                    child: _store.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const Text('Adicionar'),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
