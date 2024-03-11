import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/models/category.model.dart';
import '../../../../shared/models/custom_error.model.dart';
import '../../services/category.service.dart';

part 'category.store.g.dart';

class CategoryStore = CategoryStoreBase with _$CategoryStore;

abstract class CategoryStoreBase with Store {
  late final CategoryService _categoryService;

  CategoryStoreBase() {
    _categoryService = CategoryService();
  }

  @observable
  ObservableList<Category> categories = <Category>[].asObservable();

  @observable
  bool isLoading = false;

  String? error;

  @action
  Future<void> getCategories() async {
    try {
      error = null;
      isLoading = true;
      categories = (await _categoryService.getCategories()).asObservable();
    } on CustomError catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> removeCategory(int idCategory) async {
    try {
      error = null;
      await _categoryService.removeCategory(idCategory);
      categories.removeWhere((category) => category.id == idCategory);
      return true;
    } on CustomError catch (e) {
      error = e.message;
      return false;
    } finally {
      isLoading = false;
    }
  }
}
