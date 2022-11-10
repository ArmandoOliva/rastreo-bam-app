import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:provider/provider.dart';
import 'package:rastreo_bam/providers/providers.dart';
import 'package:rastreo_bam/services/services.dart';
import 'package:rastreo_bam/ui/inputs_decoration.dart';
import 'package:rastreo_bam/widgets/custom_circular_progress.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // authProvider.login('enviagt', '12345');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _headerLogin(),
            ChangeNotifierProvider(
              create: (_) => LoginFromProvider(),
              child: const LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}

Container _headerLogin() {
  return Container(
    width: double.infinity,
    height: 300,
    decoration: const BoxDecoration(
      color: Color.fromRGBO(28, 42, 87, 1),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    child: const Center(
      child: Image(
        image: AssetImage('logo.png'),
        height: 180,
      ),
    ),
  );
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFromProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      width: double.infinity,
      child: Form(
        key: loginForm.formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const Text('Rastreo'),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputsDecorations.authInput(
                  hintText: 'Usuario', label: 'Usuario'),
              onChanged: (value) => loginForm.username = value,
              validator: (value) {
                return (value ?? '').isEmpty ? 'Usuario inválido' : null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputsDecorations.authInput(
                  hintText: 'Contraseña', label: 'Contraseña'),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 5)
                    ? null
                    : 'Contraseña inválida';
              },
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(251, 61, 1, 1),
                  ),
                ),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        if (!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;

                        final String? errorMessage = await AuthService.login(
                            loginForm.username, loginForm.password);

                        if (errorMessage == null) {
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          print(errorMessage);
                          loginForm.isLoading = false;
                        }
                      },
                child: Text(loginForm.isLoading ? 'Espere' : 'Iniciar sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
