import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:minha_biblioteca_fase_9/features/authentication/views/register/register.page.dart';
import 'package:minha_biblioteca_fase_9/features/categories/views/categories/category.page.dart';
import 'package:minha_biblioteca_fase_9/shared/views/error.modal.dart';

import '../../../../colors.dart';
import 'login.store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginStore = LoginStore();
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faça o login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("E-mail"),
                ),
                onSaved: (value) => email = value!,
                validator: (value) {
                  if (value == null) {
                    return "E-mail obrigatório";
                  }

                  if (value.length <= 3) {
                    return "E-mail muito curto";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(
                height: 15,
              ),
              Observer(builder: (context) {
                return TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text("Senha"),
                    suffixIcon: IconButton(
                      onPressed: loginStore.toggleShowPassword,
                      icon: Icon(
                        !loginStore.showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  obscureText: !loginStore.showPassword,
                  onSaved: (newValue) => password = newValue!,
                  validator: (value) {
                    if (value == null) {
                      return "Senha obrigatória";
                    }

                    if (value.length < 6) {
                      return "Senha muito curta";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                );
              }),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: 150,
                child: Observer(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: loginStore.isLoading ? null : login,
                      child: loginStore.isLoading
                          ? const CircularProgressIndicator()
                          : const Text("Entrar"),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text.rich(
                TextSpan(
                  text: "Não tem conta aida? Toque ",
                  children: [
                    TextSpan(
                      text: "aqui",
                      style: const TextStyle(
                        color: primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const RegisterPage(),
                            ),
                          );
                        },
                    ),
                    const TextSpan(text: " para criar uma"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    final formState = formKey.currentState!;

    if (!formState.validate()) return;

    formState.save();

    final result = await loginStore.login(email, password);

    if (!mounted) return;

    if (!result) {
      ErrorModal.show(context, loginStore.error!);
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const CategoryPage(),
      ),
    );
  }
}
