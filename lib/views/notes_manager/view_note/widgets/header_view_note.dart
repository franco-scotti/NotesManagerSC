import 'package:flutter/material.dart';
import 'package:scotti_seguros/consts/app_colors.dart';

class HeaderViewNote extends StatelessWidget {
  final String title;
  final String description;

  const HeaderViewNote({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const Divider(color: AppColors.secondary),
        if (description != "") ...[
          Text(
            description,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ],
    );
  }
}
