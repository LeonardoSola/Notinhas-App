import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notinhas/models/note_color.dart';
import 'package:notinhas/repositories/note_repository.dart';

class Note {
  int? id;
  String title;
  String content;
  String date = DateTime.now().toIso8601String();
  NoteColors noteColor = NoteColors.yellow;

  Note({
    this.id,
    this.title = "",
    this.content = "",
    this.date = "",
    this.noteColor = NoteColors.yellow,
  });

  Map<String, dynamic> toMap() {
    return {
      NoteRepository.columnId: id,
      NoteRepository.columnTitle: title,
      NoteRepository.columnContent: content,
      NoteRepository.columnColorId: noteColor.index,
      NoteRepository.columnDate: date,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map[NoteRepository.columnId],
      title: map[NoteRepository.columnTitle],
      content: map[NoteRepository.columnContent],
      date: map[NoteRepository.columnDate],
      noteColor: NoteColors.values[map[NoteRepository.columnColorId]],
    );
  }

  Color get color => noteColor.color;

  get dateString => DateFormat('dd/MM/yyyy hh:mm').format(DateTime.parse(date));

  @override
  String toString() =>
      'Note{id: $id, title: $title, content: $content, date: $date, noteColor: $noteColor}';
}
