import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/views/widgets/error.modal.dart';
import 'register.store.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final store = RegisterStore(GetIt.I());
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
    _failureDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faça o cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
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
                      onChanged: (value) => store.setPassword(value),
                      obscureText: !store.obscurePassword,
                      validator: (_) {
                        if (store.password.isEmpty) {
                          return 'Preencha este campo';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    );
                  }),
                  const SizedBox(height: 10),
                  Observer(builder: (_) {
                    return TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Confirme sua senha',
                        label: const Text('Confirmar senha'),
                        suffixIcon: IconButton(
                          icon: Icon(
                            !store.obscureConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => store.setObscureConfirmPassword(),
                        ),
                      ),
                      onChanged: (value) => store.setConfirmPassword(value),
                      obscureText: !store.obscureConfirmPassword,
                      validator: (_) {
                        if (store.confirmPassword.isEmpty) {
                          return 'Preencha este campo';
                        } else if (!store.hasSamePasswords()) {
                          return 'As senhas não coincidem';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  _formKey.currentState?.validate();

                  if (emailController.text.isNotEmpty &&
                      store.password.isNotEmpty &&
                      store.hasSamePasswords()) {
                    final result = await store.register(
                      email: emailController.text,
                      password: store.password,
                    );

                    if (result && mounted) {
                      Navigator.of(context).pop();
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

                  return const Text('Criar conta');
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
