import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:notinhas/models/note.dart';
import 'package:notinhas/pages/note_page.dart';
import 'package:notinhas/repositories/note_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];
  NoteRepository repo = NoteRepository();

  void _fetchNotes() {
    repo.getNotes().then((value) => setState(() => notes = value));
  }

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
          child: SafeArea(
        child: _buildNotesList(),
      )),
    );
  }

  void goToNotePage([Note? note]) {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => NotePage(note: note)))
        .then((value) => _fetchNotes());
  }

  Widget _buildNotesList() {
    return ListView.builder(
      itemCount: notes.length + 1,
      itemBuilder: (context, index) => index >= notes.length
          ? NewNote(callback: () => goToNotePage())
          : NoteItem(
              note: notes[index], callback: () => goToNotePage(notes[index])),
    );
  }
}

class NewNote extends StatelessWidget {
  final void Function() callback;
  NewNote({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 122,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        padding: const EdgeInsets.all(2),
        child: DottedBorder(
          dashPattern: const [10],
          strokeWidth: 3,
          borderType: BorderType.RRect,
          color: Colors.grey[350]!,
          child: Center(
            child: Icon(
              Icons.add,
              size: 45,
              color: Colors.grey[350],
            ),
          ),
        ),
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  final Note note;
  final void Function() callback;
  const NoteItem({super.key, required this.note, required this.callback});

  String getLine(int index) {
    index -= 1;
    List<String> lines = note.content.split('\n');
    if (index < lines.length) {
      return lines[index];
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 3,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Card(
          color: note.color,
          elevation: 0,
          shape: const BeveledRectangleBorder(),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            child: Column(
              children: [
                if (note.title.isNotEmpty) _title(note.title),
                _lineText(getLine(1)),
                _underlineBorder(),
                const SizedBox(height: 10),
                _lineText(getLine(2)),
                _underlineBorder(),
                if (note.title.isEmpty) ...[
                  const SizedBox(height: 10),
                  _lineText(getLine(3)),
                  _underlineBorder(),
                ],
                _dateText(note.dateString),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(String text) => Text(
        text,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _lineText(String text) => SizedBox(
        width: double.infinity,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          textWidthBasis: TextWidthBasis.longestLine,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      );

  Widget _underlineBorder() => Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
      );

  Widget _dateText(String text) => SizedBox(
        width: double.infinity,
        child: Text(
          text,
          textWidthBasis: TextWidthBasis.longestLine,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      );
}
