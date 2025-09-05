import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_cubit.dart';
import 'package:scotti_seguros/services/notes_manager/notes_manager_repository.dart';
import 'package:scotti_seguros/views/notes_manager/notes_manager.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NotesManagerRepository>(
          create: (_) => NotesManagerRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NotesManagerCubit>(
            create: (context) => NotesManagerCubit(
              context.read<NotesManagerRepository>(),
            ),
          ),
        ],
        child: MyApp(),
      ),
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
