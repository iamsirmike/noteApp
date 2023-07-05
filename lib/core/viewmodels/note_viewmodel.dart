import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kngtakehome/core/models/note.dart';
import 'package:kngtakehome/core/repository/note_repository.dart';

class NoteViewModel extends ChangeNotifier {
  NoteViewModel({required NoteRepositoryImpl noteRepositoryImpl})
      : _noteRepositoryImpl = noteRepositoryImpl;

  final NoteRepositoryImpl _noteRepositoryImpl;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Future<void> saveNote(String title, String content) async {
    await getNotes();

    //sort the list (descending)
    _notes.sort((a, b) => b.docId.compareTo(a.docId));

    //insert new note on top of the list
    _notes.insert(
      0,
      Note(
        docId: _notes.isEmpty ? 1 : _notes.first.docId + 1,
        //generate random colors
        colorCode: Random().nextInt(0xffffffff),
        title: title,
        content: content,
      ),
    );

    await _noteRepositoryImpl.saveNote(notes: _notes);
  }

  Future<void> updateNote(int index, Note note) async {
    await _noteRepositoryImpl.updateNote(
        notes: _notes, index: index, note: note);

    await _noteRepositoryImpl.saveNote(notes: _notes);

    //refresh notes list
    await getNotes();
  }

  Future<void> getNotes() async {
    final data = await _noteRepositoryImpl.getNotes();
    data.sort((a, b) => b.docId.compareTo(a.docId));
    _notes = data;
    notifyListeners();
  }

  Future<void> deleteNote(int index) async {
    await _noteRepositoryImpl.deleteNote(index);

    //refresh list
    await getNotes();
  }
}
