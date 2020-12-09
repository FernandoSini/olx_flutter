import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.blueAccent[700],
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
