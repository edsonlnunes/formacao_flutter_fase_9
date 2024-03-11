import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/entities/category.entity.dart';
import '../services/get_all_categories.service.dart';
import '../services/remove_category.service.dart';

// Include generated file
part 'home.store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final GetAllCategoriesService _getAllCategoriesService;
  final RemoveCategoryService _removeCategoryService;

  HomeStoreBase(this._getAllCategoriesService, this._removeCategoryService);

  @observable
  ObservableList<Category> categories = <Category>[].asObservable();

  @observable
  bool isLoading = false;

  @observable
  String? failure;

  @action
  clearFailure() => failure = null;

  @action
  Future<void> getCategories() async {
    clearFailure();
    isLoading = true;

    try {
      final categoriesTemp = await _getAllCategoriesService();

      categories = categoriesTemp.asObservable();
      isLoading = false;
    } on DioException catch (err) {
      _onDioError(err);
    }
  }

  @action
  Future<bool> removeCategory(int categoryId) async {
    clearFailure();
    isLoading = true;

    try {
      await _removeCategoryService(categoryId);

      categories.removeWhere((category) => category.id == categoryId);
      isLoading = false;

      return true;
    } on DioException catch (err) {
      _onDioError(err);

      return false;
    }
  }

  _onDioError(DioException err) {
    final message = err.response?.data['error'];

    failure = message;
    isLoading = false;
  }
}
