import 'package:flutter/material.dart';
import 'package:scotti_seguros/consts/app_colors.dart';

class ViewNote extends StatefulWidget {
  const ViewNote({super.key});

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  void initState() {
    super.initState();
  }

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
      body: const Placeholder(),
    );
  }
}
