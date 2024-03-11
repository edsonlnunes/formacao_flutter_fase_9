// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_category.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddCategoryStore on AddCategoryStoreBase, Store {
  late final _$imageCategoryAtom =
      Atom(name: 'AddCategoryStoreBase.imageCategory', context: context);

  @override
  File? get imageCategory {
    _$imageCategoryAtom.reportRead();
    return super.imageCategory;
  }

  @override
  set imageCategory(File? value) {
    _$imageCategoryAtom.reportWrite(value, super.imageCategory, () {
      super.imageCategory = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'AddCategoryStoreBase.isLoading', context: context);

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
      Atom(name: 'AddCategoryStoreBase.failure', context: context);

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

  late final _$addCategoryAsyncAction =
      AsyncAction('AddCategoryStoreBase.addCategory', context: context);

  @override
  Future<void> addCategory(String nameCategory) {
    return _$addCategoryAsyncAction.run(() => super.addCategory(nameCategory));
  }

  late final _$AddCategoryStoreBaseActionController =
      ActionController(name: 'AddCategoryStoreBase', context: context);

  @override
  dynamic clearFailure() {
    final _$actionInfo = _$AddCategoryStoreBaseActionController.startAction(
        name: 'AddCategoryStoreBase.clearFailure');
    try {
      return super.clearFailure();
    } finally {
      _$AddCategoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setImage(File image) {
    final _$actionInfo = _$AddCategoryStoreBaseActionController.startAction(
        name: 'AddCategoryStoreBase.setImage');
    try {
      return super.setImage(image);
    } finally {
      _$AddCategoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeImage() {
    final _$actionInfo = _$AddCategoryStoreBaseActionController.startAction(
        name: 'AddCategoryStoreBase.removeImage');
    try {
      return super.removeImage();
    } finally {
      _$AddCategoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
imageCategory: ${imageCategory},
isLoading: ${isLoading},
failure: ${failure}
    ''';
  }
}
