import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rastreo_bam/providers/providers.dart';

import 'package:rastreo_bam/screens/screens.dart';
import 'package:rastreo_bam/services/services.dart';
import 'package:rastreo_bam/widgets/widgets.dart';

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
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UiProvider uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.currentIndex;

    switch (currentIndex) {
      case 0:
        return const ScanScreen();
      case 1:
        return const HistoryScreen();
      case 2:
        return const ProfileScreen();
      default:
        return const ScanScreen();
    }
  }
}
