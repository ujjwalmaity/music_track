import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String id = 'about_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("Developer: Ujjwal Maity"),
      ),
    );
  }
}
