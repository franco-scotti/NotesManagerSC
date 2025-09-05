import 'package:flutter/material.dart';
import 'package:scotti_seguros/consts/app_colors.dart';
import 'package:scotti_seguros/models/notes_manager/notes_manager.dart';

class ViewNote extends StatelessWidget {
  final Note note;

  const ViewNote({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF414988),
      appBar: AppBar(
        title: Expanded(
          child: Center(
            child: Text(
              'scotti seguros',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Text(note.title),
          ],
        ),
      ),
    );
  }
}
