import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../shared/models/custom_error.model.dart';
import '../../../../dtos/update_content.dto.dart';
import '../../../../services/content.service.dart';

part 'update_content.store.g.dart';

class UpdateContentStore = UpdateContentStoreBase with _$UpdateContentStore;

abstract class UpdateContentStoreBase with Store {
  @observable
  bool isLoading = false;

  String? error;

  @observable
  bool isChecked = false;

  @action
  void setIsChecked(bool initialIsChecked) => isChecked = initialIsChecked;

  @action
  Future<void> updateIsChecked({
    required int categoryId,
    required int contentId,
  }) async {
    try {
      isLoading = true;

      final newIsChecked = !isChecked;

      final service = ContentService(GetIt.I.get());
      await service.updateContent(UpdateContentDto(
        categoryId: categoryId,
        contentId: contentId,
        isChecked: newIsChecked,
      ));

      isChecked = newIsChecked;
    } on CustomError catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
    }
  }
}
