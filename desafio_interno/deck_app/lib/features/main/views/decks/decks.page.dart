import 'package:deck_app/features/main/views/decks/decks.store.dart';
import 'package:deck_app/features/main/views/decks/widgets/deck_list.widget.dart';
import 'package:deck_app/features/main/views/decks/widgets/empty_decks.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../shared/views/widgets/error.modal.dart';
import '../../../settings/views/settings.page.dart';
import '../new_deck/new_deck.page.dart';

class DecksPage extends StatelessWidget {
  final _store = DecksStore(GetIt.I(), GetIt.I(), GetIt.I());

  DecksPage({super.key}) {
    GetIt.I.allReady().then((_) async => await _store.getDecks());
  }

  Future<void> _navigateToNewDeck(BuildContext context) async {
    final deckTitle = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => const NewDeckPage(),
      ),
    );

    if (deckTitle != null) {
      await _store.addDeck(deckTitle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decks'),
        centerTitle: true,
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
      body: Observer(
        builder: (_) {
          if (_store.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }

          if (_store.failure != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ErrorModal.show(
                context: context,
                message: _store.failure!,
                onTap: () => _store.clearFailure(),
              );
            });
          }

          return _store.decks.isEmpty
              ? EmptyDecks(addDeck: () => _navigateToNewDeck(context))
              : DeckList(store: _store);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToNewDeck(context),
        label: const Text('Adicionar'),
      ),
    );
  }
}
