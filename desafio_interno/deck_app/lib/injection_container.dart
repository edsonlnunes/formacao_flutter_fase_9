import 'package:deck_app/features/main/services/add_deck.service.dart';
import 'package:deck_app/features/main/services/get_all_decks.service.dart';
import 'package:deck_app/features/main/services/remove_deck.service.dart';
import 'package:deck_app/features/questions/services/add_question.service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:deck_app/features/authentication/services/login.service.dart';
import 'package:deck_app/features/authentication/services/register.service.dart';
import 'package:deck_app/shared/views/theme.store.dart';
import 'package:deck_app/utils/app.constants.dart';

final sl = GetIt.I;

slLibs() {
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: AppConstants.baseUrl)),
  );
}

void slAuthentication() {
  sl.registerLazySingleton<LoginService>(
    () => LoginService(sl()),
  );

  sl.registerLazySingleton<RegisterService>(
    () => RegisterService(sl()),
  );
}

void slMain() {
  sl.registerLazySingleton<AddDeckService>(
    () => AddDeckService(sl()),
  );

  sl.registerLazySingleton<GetAllDecksService>(
    () => GetAllDecksService(sl()),
  );

  sl.registerLazySingleton<RemoveDeckService>(
    () => RemoveDeckService(sl()),
  );
}

void slQuestions() {
  sl.registerLazySingleton<AddQuestionService>(
    () => AddQuestionService(sl()),
  );
}

void slShared() {
  sl.registerLazySingleton<ThemeStore>(() => ThemeStore());
}

void init() {
  slLibs();
  slAuthentication();
  slMain();
  slQuestions();
  slShared();
}
