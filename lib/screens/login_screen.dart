import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:provider/provider.dart';
import 'package:rastreo_bam/providers/providers.dart';
import 'package:rastreo_bam/services/services.dart';
import 'package:rastreo_bam/themes/app_theme.dart';
import 'package:rastreo_bam/widgets/widgets.dart';
import 'package:rastreo_bam/ui/ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderLogin(),
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

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: const BoxDecoration(
        color: AppTheme.primary,
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppTheme.secondary,
                  ),
                ),
                onPressed: loginForm.isLoading
                    ? null
                    : () => _login(context, loginForm),
                child: Text(loginForm.isLoading ? 'Espere' : 'Iniciar sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _login(BuildContext context, LoginFromProvider loginForm) async {
  FocusScope.of(context).unfocus();
  if (!loginForm.isValidForm()) return;

  await EasyLoading.show(
    status: 'Validando credenciales...',
    maskType: EasyLoadingMaskType.black,
  );

  loginForm.isLoading = true;

  await AuthService.login(loginForm.username, loginForm.password).then((value) {
    EasyLoading.dismiss();
    if (value == null) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      Alert(context, title: 'Error', text: value);
      loginForm.isLoading = false;
    }
  });
}
