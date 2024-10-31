import 'package:flutter/cupertino.dart';

class StatsColumn extends StatelessWidget {
  final String label;
  final String value;

  StatsColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(value),
      ],
    );
  }
}