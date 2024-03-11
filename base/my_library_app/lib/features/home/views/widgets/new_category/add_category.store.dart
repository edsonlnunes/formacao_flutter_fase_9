import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../../dtos/add_category.dto.dart';
import '../../../services/add_category.service.dart';

// Include generated file
part 'add_category.store.g.dart';

// This is the class used by rest of your codebase
class AddCategoryStore = AddCategoryStoreBase with _$AddCategoryStore;

// The store-class
abstract class AddCategoryStoreBase with Store {
  final AddCategoryService _addCategoryService;

  AddCategoryStoreBase(this._addCategoryService);

  @observable
  File? imageCategory;

  @observable
  bool isLoading = false;

  @observable
  String? failure;

  @action
  clearFailure() => failure = null;

  @action
  void setImage(File image) => imageCategory = image;

  @action
  void removeImage() => imageCategory = null;

  @action
  Future<void> addCategory(String nameCategory) async {
    clearFailure();
    isLoading = true;

    try {
      await _addCategoryService(
        AddCategoryDTO(name: nameCategory, filePath: imageCategory?.path),
      );

      isLoading = false;
    } on DioException catch (err) {
      final message = err.response?.data['error'];

      failure = message;
      isLoading = false;
    }
  }
}
