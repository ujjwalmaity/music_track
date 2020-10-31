import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget {
  final String message;

  WidgetError({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
