import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_cubit.dart';
import 'package:scotti_seguros/views/notes_manager/notes_manager.dart';

import 'models/notes_manager/notes_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notesBox');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NotesManagerCubit>(
          create: (_) => NotesManagerCubit()..getAllNotes(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scotti Seguros',
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: const NotesManager(),
    );
  }
}
