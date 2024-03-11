import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_library_app/features/authentication/services/login.service.dart';
import 'package:my_library_app/features/authentication/services/register.service.dart';
import 'package:my_library_app/features/contents/services/update_content.service.dart';
import 'package:my_library_app/shared/views/theme.store.dart';
import 'package:my_library_app/utils/app.constants.dart';

import 'features/contents/services/add_content.service.dart';
import 'features/contents/services/get_all_contents.service.dart';
import 'features/contents/services/remove_content.service.dart';
import 'features/home/services/add_category.service.dart';
import 'features/home/services/get_all_categories.service.dart';
import 'features/home/services/remove_category.service.dart';

final sl = GetIt.I;

slLibs() {
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: AppConstants.baseUrl)),
  );
}

void slAuthentication() {
  sl.registerLazySingleton<LoginService>(
    () => LoginService(sl()),
  );

  sl.registerLazySingleton<RegisterService>(
    () => RegisterService(sl()),
  );
}

void slHome() {
  sl.registerLazySingleton<AddCategoryService>(
    () => AddCategoryService(sl()),
  );

  sl.registerLazySingleton<GetAllCategoriesService>(
    () => GetAllCategoriesService(sl()),
  );

  sl.registerLazySingleton<RemoveCategoryService>(
    () => RemoveCategoryService(sl()),
  );
}

void slContents() {
  sl.registerLazySingleton<AddContentService>(
    () => AddContentService(sl()),
  );

  sl.registerLazySingleton<GetAllContentsService>(
    () => GetAllContentsService(sl()),
  );

  sl.registerLazySingleton<RemoveContentService>(
    () => RemoveContentService(sl()),
  );

  sl.registerLazySingleton<UpdateContentService>(
    () => UpdateContentService(sl()),
  );
}

void slShared() {
  sl.registerLazySingleton<ThemeStore>(() => ThemeStore());
}

void init() {
  slLibs();
  slAuthentication();
  slHome();
  slContents();
  slShared();
}
