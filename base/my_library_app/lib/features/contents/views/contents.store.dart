import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/entities/content.entity.dart';
import '../dtos/add_content.dto.dart';
import '../dtos/remove_content.dto.dart';
import '../services/add_content.service.dart';
import '../services/get_all_contents.service.dart';
import '../services/remove_content.service.dart';

part 'contents.store.g.dart';

class ContentsStore = ContentsStoreBase with _$ContentsStore;

abstract class ContentsStoreBase with Store {
  final GetAllContentsService _getAllContentsService;
  final AddContentService _addContentService;
  final RemoveContentService _removeContentService;

  ContentsStoreBase(
    this._getAllContentsService,
    this._addContentService,
    this._removeContentService,
  );

  @observable
  ObservableList<Content> contents = <Content>[].asObservable();

  @observable
  bool isLoading = false;

  @observable
  String? failure;

  @action
  clearFailure() => failure = null;

  @action
  Future<void> getContents(int categoryId) async {
    clearFailure();
    isLoading = true;

    try {
      final contentsTemp = await _getAllContentsService(categoryId);

      contents = contentsTemp.asObservable();
      isLoading = false;
    } on DioException catch (err) {
      _onDioError(err);
    }
  }

  @action
  Future<void> addNewContent({
    required String contentName,
    required int categoryId,
  }) async {
    clearFailure();
    isLoading = true;

    try {
      final tempContent = await _addContentService(
        AddContentDTO(categoryId: categoryId, name: contentName),
      );

      contents.add(tempContent);
      isLoading = false;
    } on DioException catch (err) {
      _onDioError(err);
    }
  }

  @action
  Future<void> removeContent({
    required int contentId,
    required int categoryId,
  }) async {
    clearFailure();
    isLoading = true;

    try {
      await _removeContentService(
        RemoveContentDTO(categoryId: categoryId, id: contentId),
      );

      contents.removeWhere((content) => content.id == contentId);
      isLoading = false;
    } on DioException catch (err) {
      _onDioError(err);
    }
  }

  _onDioError(DioException err) {
    final message = err.response?.data['error'];

    failure = message;
    isLoading = false;
  }
}
