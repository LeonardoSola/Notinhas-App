// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:notinhas_app/models/note.dart';

import '../screens/note_form.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  var funcao;

  NoteCard(this.note, this.funcao);

  @override
  Widget build(BuildContext context) {
    debugPrint(note.toString());
    return Card(
      color: note.color,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteForm(this.note.id),
              ),
            ).then((value) => funcao())
          },
          child: ListTile(
            title: Container(
              decoration: note.title != null
                  ? const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                      ),
                    )
                  : null,
              child: note.title != null
                  ? Text(
                      "${note.title?.replaceAll('\n', '')}",
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    )
                  : null,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                  ),
                ),
                child: Text(
                  note.content.replaceAll('\n', ' '),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
