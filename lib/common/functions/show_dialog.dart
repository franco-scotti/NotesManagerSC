import 'package:flutter/material.dart';
import 'package:scotti_seguros/common/buttons/default_button.dart';
import 'package:scotti_seguros/consts/app_colors.dart';
import 'package:scotti_seguros/enums/semantic_type_enum.dart';

class ShowDialogBox {
  static Future<void> show(
    BuildContext context, {
    required String message,
    required SemanticType semanticType,
    required String title,
    required String primaryButtonText,
    required Color primaryButtonColor,
    required VoidCallback onPrimaryButtonPressed,
    String? secondaryButtonText,
    VoidCallback? onSecondaryButtonPressed,
    Color? secondaryButtonColor,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(message),
              ],
            ),
          ),
          actions: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: secondaryButtonText != null
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                if (secondaryButtonText != null) ...[
                  DefaultButton(
                    text: secondaryButtonText,
                    backgroundColor: secondaryButtonColor!,
                    onPressed: () => {onSecondaryButtonPressed!()},
                  ),
                ],
                DefaultButton(
                  text: primaryButtonText,
                  backgroundColor: primaryButtonColor,
                  onPressed: () => {onPrimaryButtonPressed()},
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
