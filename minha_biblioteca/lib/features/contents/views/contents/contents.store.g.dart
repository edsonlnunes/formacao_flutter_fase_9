// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contents.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContentsStore on ContentsStoreBase, Store {
  late final _$contentsAtom =
      Atom(name: 'ContentsStoreBase.contents', context: context);

  @override
  ObservableList<Content> get contents {
    _$contentsAtom.reportRead();
    return super.contents;
  }

  @override
  set contents(ObservableList<Content> value) {
    _$contentsAtom.reportWrite(value, super.contents, () {
      super.contents = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ContentsStoreBase.isLoading', context: context);

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

  late final _$getContentsAsyncAction =
      AsyncAction('ContentsStoreBase.getContents', context: context);

  @override
  Future<void> getContents(int categoryId) {
    return _$getContentsAsyncAction.run(() => super.getContents(categoryId));
  }

  late final _$addNewContentAsyncAction =
      AsyncAction('ContentsStoreBase.addNewContent', context: context);

  @override
  Future<bool> addNewContent(
      {required String contentName, required int categoryId}) {
    return _$addNewContentAsyncAction.run(() =>
        super.addNewContent(contentName: contentName, categoryId: categoryId));
  }

  late final _$removeContentAsyncAction =
      AsyncAction('ContentsStoreBase.removeContent', context: context);

  @override
  Future<bool> removeContent(
      {required int contentId, required int categoryId}) {
    return _$removeContentAsyncAction.run(() =>
        super.removeContent(contentId: contentId, categoryId: categoryId));
  }

  @override
  String toString() {
    return '''
contents: ${contents},
isLoading: ${isLoading}
    ''';
  }
}
