import 'package:deck_app/features/quiz/views/quiz.store.dart';
import 'package:deck_app/features/quiz/views/widgets/content_quiz.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../shared/entities/deck.entity.dart';
import 'widgets/result_quiz.widget.dart';

class QuizPage extends StatelessWidget {
  final Deck deck;
  final store = QuizStore();
  QuizPage({super.key, required this.deck}) {
    store.setDeck(deck);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: ${deck.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Observer(
          builder: ((context) {
            return store.isFinished
                ? ResultQuiz(score: store.score)
                : ContentQuiz(store: store);
          }),
        ),
      ),
    );
  }
}
