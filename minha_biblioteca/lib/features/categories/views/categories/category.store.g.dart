// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoryStore on CategoryStoreBase, Store {
  late final _$categoriesAtom =
      Atom(name: 'CategoryStoreBase.categories', context: context);

  @override
  ObservableList<Category> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(ObservableList<Category> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'CategoryStoreBase.isLoading', context: context);

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

  late final _$getCategoriesAsyncAction =
      AsyncAction('CategoryStoreBase.getCategories', context: context);

  @override
  Future<void> getCategories() {
    return _$getCategoriesAsyncAction.run(() => super.getCategories());
  }

  late final _$removeCategoryAsyncAction =
      AsyncAction('CategoryStoreBase.removeCategory', context: context);

  @override
  Future<bool> removeCategory(int idCategory) {
    return _$removeCategoryAsyncAction
        .run(() => super.removeCategory(idCategory));
  }

  @override
  String toString() {
    return '''
categories: ${categories},
isLoading: ${isLoading}
    ''';
  }
}
