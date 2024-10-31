import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  OrderButton({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}