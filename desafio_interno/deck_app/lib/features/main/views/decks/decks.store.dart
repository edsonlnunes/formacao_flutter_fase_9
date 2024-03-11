import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/entities/deck.entity.dart';
import '../../services/add_deck.service.dart';
import '../../services/get_all_decks.service.dart';
import '../../services/remove_deck.service.dart';

// Include generated file
part 'decks.store.g.dart';

class DecksStore = DecksStoreBase with _$DecksStore;

abstract class DecksStoreBase with Store {
  final AddDeckService _addDeckService;
  final GetAllDecksService _getAllDecksService;
  final RemoveDeckService _removeDeckService;

  DecksStoreBase(
    this._addDeckService,
    this._getAllDecksService,
    this._removeDeckService,
  );

  @observable
  ObservableList<Deck> decks = <Deck>[].asObservable();

  @observable
  bool isLoading = false;

  @observable
  String? failure;

  @action
  clearFailure() => failure = null;

  @action
  Future<void> getDecks() async {
    clearFailure();
    isLoading = true;

    try {
      final decksTemp = await _getAllDecksService();

      decks = decksTemp.asObservable();
      isLoading = false;
    } on DioException catch (err) {
      _onDioError(err);
    }
  }

  @action
  Future<void> addDeck(String deckTitle) async {
    clearFailure();
    isLoading = true;

    try {
      final tempDeck = await _addDeckService(deckTitle);

      decks.add(tempDeck);
      isLoading = false;
    } on DioException catch (err) {
      _onDioError(err);
    }
  }

  @action
  Future<void> removeDeck(int deckId) async {
    clearFailure();
    isLoading = true;

    try {
      await _removeDeckService(deckId);

      decks.removeWhere((deck) => deck.id == deckId);
      isLoading = false;
    } on DioException catch (err) {
      _onDioError(err);
    }
  }

  void _onDioError(DioException err) {
    final message = err.response?.data['error'];

    failure = message;
    isLoading = false;
  }
}
