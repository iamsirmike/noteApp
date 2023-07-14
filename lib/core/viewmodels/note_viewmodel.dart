import 'dart:math';

import 'package:kngtakehome/core/models/note.dart';
import 'package:kngtakehome/core/repository/note_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class NoteViewModel extends AsyncNotifier {
  NoteViewModel({required NoteRepositoryImpl noteRepositoryImpl})
      : _noteRepositoryImpl = noteRepositoryImpl;

  final NoteRepositoryImpl _noteRepositoryImpl;

  @override
  FutureOr<List<Note>> build() async {
    return getNotes();
  }

  Future<List<Note>> getNotes() async {
    final data = await _noteRepositoryImpl.getNotes();
    return data;
  }

  Future<void> saveNote(String title, String content) async {
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
      await _noteRepositoryImpl.saveNote(notes: notes);
      return getNotes();
    });
  }

  Future<void> deleteNote(int index) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _noteRepositoryImpl.deleteNote(index);
      //refresh list
      return await getNotes();
    });
  }

  Future<void> updateNote(int index, Note note) async {
    final notes = await getNotes();

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _noteRepositoryImpl.updateNote(
          notes: notes, index: index, note: note);

      await _noteRepositoryImpl.saveNote(notes: notes);

      //refresh notes list
      return getNotes();
    });
  }
}

final noteViewModelProvider = AsyncNotifierProvider(() {
  NoteRepositoryImpl noteRepositoryImpl = NoteRepositoryImpl();
  return NoteViewModel(
    noteRepositoryImpl: noteRepositoryImpl,
  );
});
