import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/models/content.model.dart';
import '../../../../shared/models/custom_error.model.dart';
import '../../dtos/add_content.dto.dart';
import '../../dtos/remove_content.dto.dart';
import '../../services/content.service.dart';

part 'contents.store.g.dart';

class ContentsStore = ContentsStoreBase with _$ContentsStore;

abstract class ContentsStoreBase with Store {
  late final ContentService _contentService;

  ContentsStoreBase() {
    _contentService = ContentService(GetIt.I.get());
  }

  @observable
  ObservableList<Content> contents = <Content>[].asObservable();

  @observable
  bool isLoading = false;

  String? error;

  @action
  Future<void> getContents(int categoryId) async {
    try {
      error = null;
      isLoading = true;
      contents = (await _contentService.getContents(categoryId)).asObservable();
    } on CustomError catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> addNewContent({
    required String contentName,
    required int categoryId,
  }) async {
    try {
      error = null;
      isLoading = true;

      final content = await _contentService.createContent(
        AddContentDto(categoryId: categoryId, name: contentName),
      );
      contents.add(content);

      return true;
    } on CustomError catch (e) {
      error = e.message;
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> removeContent({
    required int contentId,
    required int categoryId,
  }) async {
    try {
      error = null;
      await _contentService.removeContent(
        RemoveContentDto(categoryId: categoryId, contentId: contentId),
      );
      contents.removeWhere((content) => content.id == contentId);
      return true;
    } on CustomError catch (e) {
      error = e.message;
      return false;
    }
  }
}
