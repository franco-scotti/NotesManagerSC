import 'package:flutter/material.dart';
import 'package:scotti_seguros/consts/app_colors.dart';
import 'package:scotti_seguros/enums/semantic_type_enum.dart';

class ShowSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    required SemanticType semanticType,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              semanticType == SemanticType.success
                  ? Icons.check_circle
                  : Icons.error,
              color: Colors.white,
              fill: 1,
            ),
            SizedBox(width: 10),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: semanticType == SemanticType.success
            ? AppColors.successDefault
            : AppColors.errorDefault,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
