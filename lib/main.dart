import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kngtakehome/app.dart';
import 'package:kngtakehome/core/models/note.dart';
import 'package:kngtakehome/utils/injection_container.dart';

void main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();

  await loadConfigs();

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> loadConfigs() async {
  //initialize hive
  await Hive.initFlutter();
  //register adapter only when it is not registered
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(NoteAdapter());
  }
  await Hive.openBox('notes');
}
