// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class NoteForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteFormState();
  }
}

class NoteFormState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          TextField(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          switch (value) {
            case 0:
              debugPrint('Delete');
              break;
            case 1:
              debugPrint('Config');
              break;
            case 2:
              debugPrint('Confirm');
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
              Icons.delete,
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
