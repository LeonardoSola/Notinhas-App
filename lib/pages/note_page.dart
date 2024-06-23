import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notinhas/models/note.dart';
import 'package:notinhas/models/note_color.dart';
import 'package:notinhas/repositories/note_repository.dart';

class NotePage extends StatefulWidget {
  Note? note;
  NotePage({super.key, this.note});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  Note note = Note();
  NoteRepository repo = NoteRepository();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      note = widget.note!;
    }

    note.date = DateTime.now().toIso8601String();

    titleController.text = note.title;
    contentController.text = note.content;
  }

  void save() async {
    note.title = titleController.text;
    note.content = contentController.text;

    if (note.id == null) {
      await repo.insert(note);
    } else {
      await repo.update(note);
    }
    Navigator.pop(context, note);
  }

  void back() {
    Navigator.pop(context);
  }

  void config() {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => ConfigSheet(
          note: note,
          callback: (NoteColors color) {
            setState(() {
              note.noteColor = color;
            });
          },
          delete: () {
            if (note.id != null) {
              repo.delete(note.id!);
            }
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar(),
        body: _textEditor(),
        backgroundColor: note.color,
        floatingActionButton: _bottomButtom(),
      );

  AppBar _appBar() => AppBar(
        centerTitle: true,
        title: TextField(
          controller: titleController,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: 'Title',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          autocorrect: true,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: back,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: config,
          ),
        ],
      );

  Widget _bottomButtom() => FloatingActionButton(
        onPressed: save,
        shape: const CircleBorder(),
        backgroundColor: Colors.greenAccent[700]!,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.check_rounded,
          size: 35,
        ),
      );

  Widget _textEditor() => TextField(
        controller: contentController,
        decoration: const InputDecoration(
          hintText: 'Write here...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        maxLines: null,
      );
}

class ConfigSheet extends StatefulWidget {
  final Note note;
  final Function(NoteColors) callback;
  final Function() delete;
  const ConfigSheet(
      {super.key,
      required this.note,
      required this.callback,
      required this.delete});

  @override
  State<ConfigSheet> createState() => _ConfigSheetState();
}

class _ConfigSheetState extends State<ConfigSheet> {
  late Note note;
  late Function(NoteColors) callback;
  late Function() delete;

  @override
  void initState() {
    super.initState();

    note = widget.note;
    callback = widget.callback;
    delete = widget.delete;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    size: 27,
                  ),
                  SizedBox(width: 11),
                  Text(
                    'Color',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _colorButton(NoteColors.yellow),
                  _colorButton(NoteColors.orange),
                  _colorButton(NoteColors.red),
                  _colorButton(NoteColors.pink),
                  _colorButton(NoteColors.lilac),
                  _colorButton(NoteColors.blue),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _colorButton(NoteColors.cian),
                  _colorButton(NoteColors.aqua),
                  _colorButton(NoteColors.green),
                  _colorButton(NoteColors.lime),
                  _colorButton(NoteColors.brown),
                  _colorButton(NoteColors.gray),
                ],
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Delete'),
          onTap: delete,
        ),
      ],
    );
  }

  Widget _colorButton(NoteColors color) {
    bool isSelected = note.noteColor == color;

    return GestureDetector(
      onTap: () {
        setState(() {
          note.noteColor = color;
          callback(color);
        });
      },
      child: SizedBox(
        width: 50,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            color: color.color,
            shape: BoxShape.circle,
          ),
          child: isSelected
              ? const Icon(
                  Icons.check_rounded,
                  color: Colors.black54,
                  size: 35,
                )
              : null,
        ),
      ),
    );
  }
}
