import 'package:deck_app/features/authentication/dtos/account.dto.dart';

class AccountDTOBuilder {
  final String _email = 'any@email.com';
  final String _password = 'any_password';

  static AccountDTOBuilder init() => AccountDTOBuilder();

  AccountDTO build() {
    return AccountDTO(
      email: _email,
      password: _password,
    );
  }
}
