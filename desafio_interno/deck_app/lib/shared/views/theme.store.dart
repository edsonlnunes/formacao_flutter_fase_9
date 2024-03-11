import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'theme.store.g.dart';

class ThemeStore = ThemeStoreBase with _$ThemeStore;

abstract class ThemeStoreBase with Store {
  @observable
  ThemeMode themeMode = ThemeMode.system;

  @action
  void changeThemeMode(ThemeMode mode) => themeMode = mode;
}
