import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:my_library_app/features/contents/dtos/update_content.dto.dart';

import '../../../services/update_content.service.dart';

part 'update_content.store.g.dart';

class UpdateContentStore = UpdateContentStoreBase with _$UpdateContentStore;

abstract class UpdateContentStoreBase with Store {
  final UpdateContentService _updateContentService;

  UpdateContentStoreBase(this._updateContentService);

  @observable
  bool isLoading = false;

  @observable
  String? failure;

  @observable
  bool isChecked = false;

  @action
  void clearFailure() => failure = null;

  @action
  void setIsChecked(bool initialIsChecked) => isChecked = initialIsChecked;

  @action
  Future<void> updateIsChecked({
    required int categoryId,
    required int contentId,
  }) async {
    clearFailure();
    isLoading = true;

    try {
      await _updateContentService(
        UpdateContentDTO(
          categoryId: categoryId,
          id: contentId,
          isChecked: !isChecked,
        ),
      );

      isChecked = !isChecked;
      isLoading = false;
    } on DioException catch (err) {
      final message = err.response?.data['error'];

      failure = message;
      isLoading = false;
    }
  }
}
