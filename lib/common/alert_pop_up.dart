import 'package:flutter/material.dart';

class DialogUtils {
  /// Displays a general dialog with custom parameters.
  static void showDialogBox({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onButtonPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (onButtonPressed != null) onButtonPressed();
              },
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }

  /// Displays an error dialog specifically.
  static void showErrorDialog({
    required BuildContext context,
    required String message,
    String title = 'Error',
    String buttonText = 'OK',
  }) {
    showDialogBox(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
    );
  }

  /// Displays a success dialog.
  static void showSuccessDialog({
    required BuildContext context,
    required String message,
    String title = 'Success',
    String buttonText = 'OK',
  }) {
    showDialogBox(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
    );
  }
}
