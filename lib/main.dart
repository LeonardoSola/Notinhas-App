// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:notinhas_app/screens/home.dart';

void main() => runApp(NotinhasApp());

class NotinhasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEAEAEA)),
      home: SafeArea(child: Home()),
    );
  }
}
