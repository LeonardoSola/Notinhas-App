// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:notinhas_app/database/dao/notes_dao.dart';

import '../models/note.dart';
import 'note_config.dart';

class NoteForm extends StatefulWidget {
  final int id;
  const NoteForm(this.id);

  @override
  State<StatefulWidget> createState() {
    return NoteFormState(id);
  }
}


class NoteFormState extends State {
  final int id;
  final NotesDao _dao = NotesDao();
  int color = 1;
  dynamic realColor = 1;
  String? title = '';
  final TextEditingController _contentController= TextEditingController();
  NoteFormState(this.id);
  Note note = Note(0,'   ',1);


  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      reverse: true,
      child:  FutureBuilder<Note>(
        future: _dao.find(id),
        builder: (context, snapshot){
          if(id == 0) return TextFormNote(_contentController);
          if(snapshot.data == null) return Loading();
          final Note note = snapshot.data as Note;
          realColor = note.color;
          title = note.title;
          _contentController.text = note.content;
          debugPrint('${note.color}');
          return TextFormField(
            autofocus: true,
            keyboardType: TextInputType.text,
            textAlignVertical: TextAlignVertical.top,
            textAlign: TextAlign.start,
            maxLines: null,
            decoration: InputDecoration(
              filled: true,
              fillColor: note.color as Color?,
              contentPadding: const EdgeInsets.only(top: 40, right: 15, left: 15, bottom: 720),
            ),
            controller: _contentController,
          );
        },
      ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          switch (value) {
            case 0:
              Navigator.pop(context, 'ok');
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteConfig()));
              break;
            case 2:
              if(id == 0){
                _dao
                    .save(Note(0, _contentController.text, color, title: (title == ''? null : title)))
                    .then((value)=>Navigator.of(context).maybePop());
              }else{
                debugPrint('$id, ${_contentController.text}, $title, $color');
                _dao
                    .update(id, _contentController.text, title as String, color)
                    .then((value) =>Navigator.of(context).maybePop());
              }
              break;
            default:
          }
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.arrow_back,
              color: Colors.red,
              size: 50,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.settings,
              color: Colors.grey,
              size: 50,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.check,
              color: Colors.green,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        Text('Loading...'),
        SizedBox(width: double.infinity),
      ],
    );
  }
}

class TextFormNote extends StatelessWidget{
  TextEditingController _contentController;
  dynamic realColor;

  TextFormNote(this._contentController);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.text,
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.start,
      maxLines: null,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Color(0xffFDFFA4),
        contentPadding: EdgeInsets.only(top: 40, right: 15, left: 15, bottom: 620),
      ),
      controller: _contentController,
    );
  }
}