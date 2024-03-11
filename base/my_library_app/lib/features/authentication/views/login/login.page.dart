import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:my_library_app/features/home/views/home.page.dart';

import '../../../../shared/views/widgets/error.modal.dart';
import '../../../../themes/app_colors.dart';
import '../register/register.page.dart';
import 'login.store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final store = LoginStore(GetIt.I());
  final _formKey = GlobalKey<FormState>();
  late final ReactionDisposer _failureDispose;

  @override
  void initState() {
    super.initState();

    _failureDispose = reaction<String?>((_) => store.failure, (failure) {
      if (failure != null) {
        ErrorModal.show(
          context: context,
          message: failure,
          onTap: () => store.clearFailure(),
        );
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _failureDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Faça o login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Digite seu e-mail',
                  label: Text('E-mail'),
                ),
                onChanged: (value) => emailController.text = value,
                validator: (_) {
                  if (emailController.text.isEmpty) {
                    return 'Preencha este campo';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 10),
              Observer(builder: (_) {
                return TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Digite sua senha',
                    label: const Text('Senha'),
                    suffixIcon: IconButton(
                      icon: Icon(
                        !store.obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () => store.setObscurePassword(),
                    ),
                  ),
                  onChanged: (value) => passwordController.text = value,
                  obscureText: !store.obscurePassword,
                  validator: (_) {
                    if (passwordController.text.isEmpty) {
                      return 'Preencha este campo';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                );
              }),
              const SizedBox(height: 20),
              SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState?.validate();

                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      final result = await store.login(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      if (result && mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => HomePage(),
                          ),
                          (_) => false,
                        );
                      }
                    }
                  },
                  child: Observer(builder: (_) {
                    if (store.isLoading) {
                      return const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    return const Text('Entrar');
                  }),
                ),
              ),
              const SizedBox(height: 15),
              Text.rich(
                TextSpan(text: 'Não tem conta ainda? Toque ', children: [
                  TextSpan(
                    text: 'aqui',
                    style: TextStyle(color: appColors.primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        );
                      },
                  ),
                  const TextSpan(text: ' para criar uma.'),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
