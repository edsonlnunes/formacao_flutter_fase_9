import 'dart:io';

import 'package:mobx/mobx.dart';

import '../../../../../../shared/models/custom_error.model.dart';
import '../../../../dtos/add_category.dto.dart';
import '../../../../services/category.service.dart';

part 'add_category.store.g.dart';

class AddCategoryStore = AddCategoryStoreBase with _$AddCategoryStore;

abstract class AddCategoryStoreBase with Store {
  @observable
  File? imageCategory;

  @observable
  bool isLoading = false;

  String? error;

  @action
  void setImage(File image) => imageCategory = image;

  @action
  void removeImage() => imageCategory = null;

  @action
  Future<bool> addCategory(String nameCategory) async {
    try {
      error = null;
      isLoading = true;

      final service = CategoryService();
      await service.createCategory(
        AddCategoryDto(
          name: nameCategory,
          filePath: imageCategory?.path,
        ),
      );

      isLoading = false;
      return true;
    } on CustomError catch (e) {
      error = e.message;
      return false;
    } finally {
      isLoading = false;
    }
  }
}
