// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on LoginStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'LoginStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$failureAtom =
      Atom(name: 'LoginStoreBase.failure', context: context);

  @override
  String? get failure {
    _$failureAtom.reportRead();
    return super.failure;
  }

  @override
  set failure(String? value) {
    _$failureAtom.reportWrite(value, super.failure, () {
      super.failure = value;
    });
  }

  late final _$obscurePasswordAtom =
      Atom(name: 'LoginStoreBase.obscurePassword', context: context);

  @override
  bool get obscurePassword {
    _$obscurePasswordAtom.reportRead();
    return super.obscurePassword;
  }

  @override
  set obscurePassword(bool value) {
    _$obscurePasswordAtom.reportWrite(value, super.obscurePassword, () {
      super.obscurePassword = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('LoginStoreBase.login', context: context);

  @override
  Future<bool> login({required String email, required String password}) {
    return _$loginAsyncAction
        .run(() => super.login(email: email, password: password));
  }

  late final _$LoginStoreBaseActionController =
      ActionController(name: 'LoginStoreBase', context: context);

  @override
  dynamic clearFailure() {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.clearFailure');
    try {
      return super.clearFailure();
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setObscurePassword() {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.setObscurePassword');
    try {
      return super.setObscurePassword();
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
failure: ${failure},
obscurePassword: ${obscurePassword}
    ''';
  }
}
