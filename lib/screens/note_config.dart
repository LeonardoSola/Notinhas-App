// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class NoteConfig extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteConfigState();
  }
}

class NoteConfigState extends State {
  final TextEditingController _titleController = TextEditingController();

  bool check = false;

  void changeState(){
    debugPrint('set State');
    setState(() {
      check = check?false:true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isChecked = false;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  labelText: 'Titulo',
                  hintText: 'Sem titulo',
                ),
                keyboardType: TextInputType.number,
                controller: _titleController,
              ),
            ),
            Row(
              children: [
                ColorCheckBox(const Color(0xffFDFFA4), changeState, isChecked: check,),
                ColorCheckBox(const Color(0xffFDEBA4), changeState, isChecked: check,),
                ColorCheckBox(const Color(0xffFDA4A4), changeState, isChecked: check,),
                ColorCheckBox(const Color(0xffFDA4FF), changeState, isChecked: check,),
                ColorCheckBox(const Color(0xffD1A4FF), changeState, isChecked: check,),
                ColorCheckBox(const Color(0xffB19EFF), changeState, isChecked: check,),
              ],
            ),
            Row(
              children: [
                ColorCheckBox(const Color(0xff99FFF9), changeState, isChecked: check,),
                ColorCheckBox(const Color(0xff81FFC2), changeState, isChecked: check,),
                ColorCheckBox(const Color(0xff8EFFAA), changeState, isChecked: check,),
                ColorCheckBox(const Color(0xffC5FF7C), changeState, isChecked: check,),
                ColorCheckBox(const Color(0xffC89292), changeState, isChecked: check,),
                ColorCheckBox(const Color(0xffD9D9D9), changeState, isChecked: check,),
              ],
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          switch (value) {
            case 0:
              debugPrint('Close');
              break;
            case 1:
              debugPrint('Delete');
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
              Icons.close,
              color: Colors.blue,
              size: 50,
            ),
          ),
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

class ColorCheckBox extends StatelessWidget{
  bool isChecked = false;
  Color? color;

  var funcao;

  ColorCheckBox(this.color, this.funcao, {isChecked});

  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: Transform.scale(
       scale: 2.5,
       child: Checkbox(
         checkColor: Colors.grey[600],
         fillColor: MaterialStateProperty.all(color),
         value: isChecked,
         shape: const CircleBorder(),
         onChanged: ( value) {
             funcao();
         },

       ),
     ),
   );
  }

}