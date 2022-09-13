import 'package:flutter/material.dart';

class Allmethod {
  Color dartcolor = Colors.green.shade400;

  Widget ShowProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  SizedBox Space() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Text Showapptext(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 22,
          color: Colors.green.shade400,
          fontWeight: FontWeight.bold,
        ),
      );

  Container Showlogo() {
    return Container(
      width: 120.0,
      child: Image.asset("assets/images/logo.png"),
    );
  }

  Allmethod();
}
