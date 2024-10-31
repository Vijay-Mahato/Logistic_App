import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_location_alt, color: Colors.green, size: 36),
              SizedBox(height: 8),
              Text(
                'You are online',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}