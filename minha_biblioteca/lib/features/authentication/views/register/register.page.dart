import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:minha_biblioteca_fase_9/shared/views/error.modal.dart';

import '../../../../colors.dart';
import 'register.store.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerStore = RegisterStore();
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faça o cadastro"),
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
                onSaved: (newValue) => email = newValue!,
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
                      onPressed: registerStore.toggleShowPassword,
                      icon: Icon(!registerStore.showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  onChanged: (value) => password = value,
                  obscureText: !registerStore.showPassword,
                  validator: (value) {
                    if (value == null) {
                      return "Senha obrigatória";
                    }

                    if (value.length < 6) {
                      return "Senha muito curta";
                    }

                    if (value != confirmPassword) {
                      return "Senhas devem ser iguais";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                );
              }),
              const SizedBox(
                height: 15,
              ),
              Builder(builder: (context) {
                return TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text("Confirmar senha"),
                    suffixIcon: IconButton(
                      onPressed: registerStore.toggleShowPassword,
                      icon: Icon(!registerStore.showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  onChanged: (value) => confirmPassword = value,
                  obscureText: !registerStore.showPassword,
                  validator: (value) {
                    if (value != password) {
                      return "Senhas devem ser iguais";
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
                      onPressed: registerStore.isLoading ? null : createAccount,
                      child: registerStore.isLoading
                          ? const CircularProgressIndicator()
                          : const Text("Criar conta"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createAccount() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    formKey.currentState!.save();

    final result = await registerStore.createAccount(email, password);

    if (!mounted) return;

    if (!result) {
      ErrorModal.show(context, registerStore.error!);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Conta criada com sucesso"),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 3),
      ),
    );

    Navigator.of(context).pop();
  }
}
