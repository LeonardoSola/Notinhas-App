import 'package:flutter/material.dart';

enum NoteColors {
  yellow,
  orange,
  red,
  pink,
  lilac,
  blue,
  cian,
  aqua,
  green,
  lime,
  brown,
  gray
}

extension NoteColorsExtension on NoteColors {
  Color get color {
    switch (this) {
      case NoteColors.yellow:
        return const Color(0xFFFDFFA4);
      case NoteColors.orange:
        return Colors.orange[200]!;
      case NoteColors.red:
        return Colors.red[200]!;
      case NoteColors.pink:
        return Colors.pink[200]!;
      case NoteColors.lilac:
        return Colors.purple[200]!;
      case NoteColors.blue:
        return Colors.blue[300]!;
      case NoteColors.cian:
        return Colors.cyan[200]!;
      case NoteColors.aqua:
        return const Color(0xFF99FFF9);
      case NoteColors.green:
        return const Color(0xFFC1FFA4);
      case NoteColors.lime:
        return const Color(0xFFC5FF7C);
      case NoteColors.brown:
        return Colors.brown[400]!;
      case NoteColors.gray:
        return Colors.grey[300]!;
    }
  }
}
