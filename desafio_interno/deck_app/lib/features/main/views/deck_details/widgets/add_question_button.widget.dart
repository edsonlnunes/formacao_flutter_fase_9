import 'package:flutter/material.dart';

import '../../../../../shared/entities/question.entity.dart';
import '../../../../questions/views/add_question.page.dart';
import '../deck_detail.store.dart';

class AddQuestionButton extends StatelessWidget {
  final DeckDetailStore _store;

  const AddQuestionButton({
    Key? key,
    required DeckDetailStore store,
  })  : _store = store,
        super(key: key);

  Future<void> _addQuestion(BuildContext context) async {
    final question = await Navigator.of(context).push<Question>(
      MaterialPageRoute(
        builder: (_) => AddQuestionPage(
          deckId: _store.deck!.id,
        ),
      ),
    );

    if (question != null) {
      _store.addNewQuestion(question);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 250,
      child: OutlinedButton(
        onPressed: () => _addQuestion(context),
        child: const Text(
          'Add Cartão',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
