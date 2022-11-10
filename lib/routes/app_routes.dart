import 'package:flutter/material.dart';

import 'package:rastreo_bam/models/models.dart';
import 'package:rastreo_bam/screens/screens.dart';

class AppRoute {
  static const String initialRoute = 'home';

  static final List<MenuOption> menuOptions = [
    MenuOption(
      route: 'login',
      name: 'Login Screen',
      screen: const LoginScreen(),
      icon: Icons.home,
    ),
    MenuOption(
      route: 'profile',
      name: 'Profile Screen',
      screen: const ProfileScreen(),
      icon: Icons.home,
    ),
  ];

  static Map<String, Widget Function(BuildContext)> routes() {
    Map<String, Widget Function(BuildContext)> appRoute = {};

    appRoute.addAll({'home': (BuildContext context) => const HomeScreen()});

    for (var option in menuOptions) {
      appRoute.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoute;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) => const HomeScreen(),
    );
  }
}
