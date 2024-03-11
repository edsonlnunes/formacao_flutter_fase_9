import 'package:flutter/material.dart';

import '../../../../quiz/views/quiz.page.dart';
import '../deck_detail.store.dart';

class StartQuizButton extends StatelessWidget {
  final DeckDetailStore store;
  const StartQuizButton({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => QuizPage(deck: store.deck!),
            ),
          );
        },
        child: const Text(
          'Iniciar Quiz',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
