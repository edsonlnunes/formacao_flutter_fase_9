// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_content.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpdateContentStore on UpdateContentStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'UpdateContentStoreBase.isLoading', context: context);

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
      Atom(name: 'UpdateContentStoreBase.failure', context: context);

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

  late final _$isCheckedAtom =
      Atom(name: 'UpdateContentStoreBase.isChecked', context: context);

  @override
  bool get isChecked {
    _$isCheckedAtom.reportRead();
    return super.isChecked;
  }

  @override
  set isChecked(bool value) {
    _$isCheckedAtom.reportWrite(value, super.isChecked, () {
      super.isChecked = value;
    });
  }

  late final _$updateIsCheckedAsyncAction =
      AsyncAction('UpdateContentStoreBase.updateIsChecked', context: context);

  @override
  Future<void> updateIsChecked(
      {required int categoryId, required int contentId}) {
    return _$updateIsCheckedAsyncAction.run(() =>
        super.updateIsChecked(categoryId: categoryId, contentId: contentId));
  }

  late final _$UpdateContentStoreBaseActionController =
      ActionController(name: 'UpdateContentStoreBase', context: context);

  @override
  void clearFailure() {
    final _$actionInfo = _$UpdateContentStoreBaseActionController.startAction(
        name: 'UpdateContentStoreBase.clearFailure');
    try {
      return super.clearFailure();
    } finally {
      _$UpdateContentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsChecked(bool initialIsChecked) {
    final _$actionInfo = _$UpdateContentStoreBaseActionController.startAction(
        name: 'UpdateContentStoreBase.setIsChecked');
    try {
      return super.setIsChecked(initialIsChecked);
    } finally {
      _$UpdateContentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
failure: ${failure},
isChecked: ${isChecked}
    ''';
  }
}
