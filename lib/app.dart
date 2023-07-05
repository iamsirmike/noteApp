import 'package:flutter/material.dart';
import 'package:kngtakehome/core/repository/note_repository.dart';
import 'package:kngtakehome/core/viewmodels/note_viewmodel.dart';
import 'package:kngtakehome/utils/colors.dart';
import 'package:kngtakehome/views/home/home.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteViewModel>(
          create: (_) => NoteViewModel(
            noteRepositoryImpl: NoteRepositoryImpl(),
          ),
        ),
      ],
      child: GlobalLoaderOverlay(
        overlayOpacity: 0.4,
        child: MaterialApp(
          title: 'Note App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: AppColors.backgroundColor,
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}
