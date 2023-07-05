import 'package:hive_flutter/hive_flutter.dart';
import 'package:kngtakehome/core/models/note.dart';

abstract class NoteRepository {
  Future<void> saveNote({required List<Note> notes});
  Future<void> updateNote(
      {required List<Note> notes, required int index, required Note note});
  Future<List<Note>> getNotes();
  Future<void> deleteNote(int index);
}

class NoteRepositoryImpl implements NoteRepository {
  @override
  Future<void> saveNote({required List<Note> notes}) async {
    Box box = Hive.box('notes');
    box.put('NOTES', notes);
  }

  @override
  Future<void> updateNote({
    required List<Note> notes,
    required int index,
    required Note note,
  }) async {
    notes[index] = note;
  }

  @override
  Future<List<Note>> getNotes() async {
    Box box = Hive.box('notes');
    final notes = await box.get('NOTES');
    if (notes == null) {
      return [];
    }
    return notes.cast<Note>();
  }

  @override
  Future<void> deleteNote(int index) async {
    final notes = await getNotes();
    notes.removeAt(index);
    await saveNote(notes: notes);
  }
}
