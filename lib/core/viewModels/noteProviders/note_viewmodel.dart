import 'dart:math';

import 'package:kngtakehome/core/models/note.dart';
import 'package:kngtakehome/core/repository/note_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_viewmodel.g.dart';

@riverpod
class NoteViewModel extends _$NoteViewModel {
  @override
  FutureOr<List<Note>> build() async {
    return getNotes();
  }

  Future<List<Note>> getNotes() async {
    final noteRepositoryImpl = ref.read(noteRepositoryImplProvider);
    final data = await noteRepositoryImpl.getNotes();
    return data;
  }

  Future<void> saveNote(String title, String content) async {
    final noteRepositoryImpl = ref.read(noteRepositoryImplProvider);
    state = const AsyncValue.loading();

    final notes = await getNotes();

    // final notes = await getNotes(getNotesRef);

    //sort the list (descending)
    notes.sort((a, b) => b.docId.compareTo(a.docId));

    //insert new note on top of the list
    notes.insert(
      0,
      Note(
        docId: notes.isEmpty ? 1 : notes.first.docId + 1,
        //generate random colors
        colorCode: Random().nextInt(0xffffffff),
        title: title,
        content: content,
      ),
    );

    state = await AsyncValue.guard(() async {
      await noteRepositoryImpl.saveNote(notes: notes);
      return getNotes();
    });
  }

  Future<void> deleteNote(int index) async {
    final noteRepositoryImpl = ref.read(noteRepositoryImplProvider);

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await noteRepositoryImpl.deleteNote(index);
      //refresh list
      return await getNotes();
    });
  }

  Future<void> updateNote(int index, Note note) async {
    final noteRepositoryImpl = ref.read(noteRepositoryImplProvider);

    final notes = await getNotes();

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await noteRepositoryImpl.updateNote(
          notes: notes, index: index, note: note);

      await noteRepositoryImpl.saveNote(notes: notes);

      //refresh notes list
      return getNotes();
    });
  }
}


//USE THIS TO CREATE A PROVIDER IF WE DON'T USE CODE GENERATION
// final noteViewModelProvider =
//     AsyncNotifierProvider<AsyncNoteViewModel, List<Note>>(() {
//   return AsyncNoteViewModel();
// });
