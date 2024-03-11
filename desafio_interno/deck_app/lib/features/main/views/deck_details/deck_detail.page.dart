import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/entities/deck.entity.dart';
import 'deck_detail.store.dart';
import 'widgets/add_question_button.widget.dart';
import 'widgets/start_quiz_button.widget.dart';

class DeckDetailPage extends StatelessWidget {
  final _store = DeckDetailStore();

  DeckDetailPage({
    super.key,
    required Deck deck,
  }) {
    _store.init(deck);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_store.deck!.name),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _store.deck!.name,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Observer(
                    builder: (context) {
                      return Text(
                        '${_store.deck!.questions.length} cartões',
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  AddQuestionButton(store: _store),
                  const SizedBox(height: 20),
                  Observer(builder: (_) {
                    if (_store.deck?.questions.isEmpty ?? false) {
                      return Container();
                    }

                    return StartQuizButton(store: _store);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
