import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:my_library_app/features/authentication/services/register.service.dart';

import '../../dtos/account.dto.dart';

part 'register.store.g.dart';

class RegisterStore = RegisterStoreBase with _$RegisterStore;

abstract class RegisterStoreBase with Store {
  final RegisterService _registerService;

  RegisterStoreBase(this._registerService);

  @observable
  bool isLoading = false;

  @observable
  String? failure;

  @observable
  bool obscurePassword = false;

  @observable
  bool obscureConfirmPassword = false;

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @action
  void clearFailure() => failure = null;

  @action
  void setObscurePassword() => obscurePassword = !obscurePassword;

  @action
  void setObscureConfirmPassword() =>
      obscureConfirmPassword = !obscureConfirmPassword;

  @action
  void setPassword(String value) => password = value;

  @action
  bool hasSamePasswords() => password == confirmPassword;

  @action
  setConfirmPassword(String value) => confirmPassword = value;

  @action
  Future<bool> register({
    required String email,
    required String password,
  }) async {
    clearFailure();
    isLoading = true;

    try {
      await _registerService(AccountDTO(email: email, password: password));

      isLoading = false;

      return true;
    } on DioException catch (err) {
      final message = err.response?.data['error'];

      failure = message;
      isLoading = false;

      return false;
    }
  }
}
