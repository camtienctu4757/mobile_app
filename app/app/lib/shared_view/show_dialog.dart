import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String errorMessage) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Prevents dismissal by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(errorMessage), // Display the error message
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
