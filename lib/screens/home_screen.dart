import 'package:flutter/material.dart';
import 'package:rastreo_bam/services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout();
              Navigator.restorablePushNamed(context, 'login');
            },
            icon: const Icon(Icons.login_outlined),
          )
        ],
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
