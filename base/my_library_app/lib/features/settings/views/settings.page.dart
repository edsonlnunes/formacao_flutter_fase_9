import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:my_library_app/features/authentication/views/login/login.page.dart';
import 'package:my_library_app/utils/app.constants.dart';

import '../../../shared/views/theme.store.dart';
import '../../../themes/app_colors.dart';

class SettingsPage extends StatelessWidget {
  final store = GetIt.I.get<ThemeStore>();

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferências do usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Aparência'),
                Observer(builder: (_) {
                  return SizedBox(
                    width: 150,
                    child: DropdownButton(
                      onChanged: (value) => store.changeThemeMode(value!),
                      value: store.themeMode,
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: const [
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text('Dia'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text('Noite'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text('Sistema'),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            InkWell(
              onTap: () {
                AppConstants.token = null;

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (c) => const LoginPage()),
                  (route) => false,
                );
              },
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sair'),
                    Icon(
                      Icons.logout,
                      color: appColors.primaryColor,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
