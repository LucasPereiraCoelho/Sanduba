import 'package:flutter/material.dart';
import 'package:app_delivery/views/login_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: false
    ),
    home: LoginPage(),
  ));
}

