// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterStore on RegisterStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'RegisterStoreBase.isLoading', context: context);

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
      Atom(name: 'RegisterStoreBase.failure', context: context);

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
      Atom(name: 'RegisterStoreBase.obscurePassword', context: context);

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

  late final _$obscureConfirmPasswordAtom =
      Atom(name: 'RegisterStoreBase.obscureConfirmPassword', context: context);

  @override
  bool get obscureConfirmPassword {
    _$obscureConfirmPasswordAtom.reportRead();
    return super.obscureConfirmPassword;
  }

  @override
  set obscureConfirmPassword(bool value) {
    _$obscureConfirmPasswordAtom
        .reportWrite(value, super.obscureConfirmPassword, () {
      super.obscureConfirmPassword = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: 'RegisterStoreBase.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: 'RegisterStoreBase.confirmPassword', context: context);

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('RegisterStoreBase.register', context: context);

  @override
  Future<bool> register({required String email, required String password}) {
    return _$registerAsyncAction
        .run(() => super.register(email: email, password: password));
  }

  late final _$RegisterStoreBaseActionController =
      ActionController(name: 'RegisterStoreBase', context: context);

  @override
  void clearFailure() {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.clearFailure');
    try {
      return super.clearFailure();
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setObscurePassword() {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.setObscurePassword');
    try {
      return super.setObscurePassword();
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setObscureConfirmPassword() {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.setObscureConfirmPassword');
    try {
      return super.setObscureConfirmPassword();
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool hasSamePasswords() {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.hasSamePasswords');
    try {
      return super.hasSamePasswords();
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setConfirmPassword(String value) {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
failure: ${failure},
obscurePassword: ${obscurePassword},
obscureConfirmPassword: ${obscureConfirmPassword},
password: ${password},
confirmPassword: ${confirmPassword}
    ''';
  }
}
