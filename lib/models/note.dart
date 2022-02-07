import 'package:flutter/material.dart';

class Note {
  final int _id;
  final String? title;
  final String content;
  int? _color;

  Note(this._id, this.content, this._color, {this.title});

  @override
  String toString() {
    // ignore: unnecessary_this
    return 'Nota: {id:${this._id}, title: ${this.title}, content: ${this.content}, color = ${this._color}}';
  }

  dynamic get color {
    switch (_color) {
      case 1:
        return const Color(0xffFDFFA4);
      case 2:
        return const Color(0xffc1ffa4);
      case 3:
        return const Color(0xffFDA4A4);
      case 4:
        return const Color(0xffFDA4FF);
      case 5:
        return const Color(0xffD1A4FF);
      case 6:
        return const Color(0xffB19EFF);
      case 7:
        return const Color(0xff99FFF9);
      case 8:
        return const Color(0xff81FFC2);
      case 9:
        return const Color(0xff8EFFAA);
      case 10:
        return const Color(0xffC5FF7C);
      case 11:
        return const Color(0xffC89292);
      case 12:
        return const Color(0xffD9D9D9);
    }
  }

  dynamic getColor() => _color;

  set color(value) => _color = value;
}
