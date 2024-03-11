import 'package:deck_app/shared/views/theme.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../../shared/entities/deck.entity.dart';
import '../../../../../shared/views/widgets/error.modal.dart';
import '../../deck_details/deck_detail.page.dart';
import '../decks.store.dart';

class DeckList extends StatelessWidget {
  final DecksStore _store;

  const DeckList({
    super.key,
    required DecksStore store,
  }) : _store = store;

  Future<void> _navigateToDeckDetail({
    required BuildContext context,
    required Deck deck,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DeckDetailPage(deck: deck),
      ),
    );

    await _store.getDecks();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_store.failure != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ErrorModal.show(
            context: context,
            message: _store.failure!,
            onTap: () => _store.clearFailure(),
          );
        });
      }

      return ListView.builder(
        itemCount: _store.decks.length,
        itemBuilder: (_, index) {
          final deck = _store.decks[index];
          return InkWell(
            onTap: () => _navigateToDeckDetail(
              context: context,
              deck: deck,
            ),
            onLongPress: () async => await _store.removeDeck(deck.id),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: GetIt.I<ThemeStore>().themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    deck.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${deck.questions.length} ${deck.questions.length == 1 ? 'cartão' : 'cartões'}',
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
