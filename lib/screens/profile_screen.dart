import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rastreo_bam/providers/providers.dart' show UiProvider;
import 'package:rastreo_bam/services/services.dart' show AuthService;
import 'package:rastreo_bam/themes/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.readUserInfo(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
        if (!snapshot.hasData) return const Text('');

        final String nombre = snapshot.data?['usr_nombre'] ?? '';
        final String username = snapshot.data?['usr_cod'] ?? '';

        return SingleChildScrollView(
          child: Column(
            children: [
              _UserInfo(nombre: nombre, username: username),
              _LogoutOption(),
            ],
          ),
        );
      },
    );
  }
}

class _UserInfo extends StatelessWidget {
  final String nombre;
  final String username;
  const _UserInfo({
    Key? key,
    required this.nombre,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.3),
            blurRadius: 7,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              backgroundColor: AppTheme.secondary,
              radius: 60,
              child: Icon(
                Icons.person_outline,
                size: 75,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              nombre,
              style: const TextStyle(fontSize: 20),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(username),
          ],
        ),
      ),
    );
  }
}

class _LogoutOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final uiProvider = Provider.of<UiProvider>(context, listen: false);
        uiProvider.currentIndex = 0;
        AuthService.logout();
        Navigator.pushReplacementNamed(context, 'login');
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.3),
              blurRadius: 7,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: const ListTile(
          leading: Icon(Icons.login_outlined, size: 30),
          title: Text(
            'Cerrar Sesión',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
