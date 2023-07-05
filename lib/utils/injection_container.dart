import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  //In case of any injections it will be done here. eg below:
  // locator.registerLazySingleton(() => NoteRepositoryImpl());
}
