// ignore_for_file: use_key_in_widget_constructors, use_function_type_syntax_for_parameters, non_constant_identifier_names, unused_import

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:notinhas_app/components/noteCard.dart';
import 'package:notinhas_app/database/dao/notes_dao.dart';
import 'package:notinhas_app/models/note.dart';

import 'note_form.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State {
  final NotesDao _dao = NotesDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<List<Note>>(
          initialData: [Note(1, 'content', 1)],
          future: _dao.findAll(),
          builder: (context, snapshot) {
            final List<Note> notes = snapshot.data as List<Note>;
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index == notes.length) {
                  return NewCard(newForm);
                } else {
                  final Note note = notes[index];
                  return NoteCard(note, newState);
                }
              },
              itemCount: notes.length + 1,
            );
          },
        ),
      ),
    );
  }

  void newForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteForm(0),
      ),);

  }

  void newState() {
    setState(() {});
  }
}

// ignore: must_be_immutable
class NewCard extends StatelessWidget {
  dynamic funcao;

  NewCard(this.funcao);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 60, left: 10, right: 10),
      child: Material(
        child: InkWell(
          onTap: funcao,
          child: DottedBorder(
            strokeCap: StrokeCap.square,
            strokeWidth: 2,
            color: Colors.black38,
            dashPattern: const [8, 8],
            padding: const EdgeInsets.all(30),
            child: Column(
              children: const [
                Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.black38,
                ),
                SizedBox(
                  width: double.infinity,
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
