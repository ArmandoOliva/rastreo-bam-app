import 'package:flutter/material.dart';

class Alert {
  final BuildContext context;
  final String title;
  final String text;

  Alert(
    this.context, {
    required this.title,
    required this.text,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text(text)],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Aceptar'),
          )
        ],
      ),
    );
  }

/*
  static void showAlert(BuildContext context,
      {required String title, required String text}) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text(text)],
        ),
      ),
    );
  }*/
}
