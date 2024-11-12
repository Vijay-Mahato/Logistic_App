import 'package:flutter/material.dart';

class OrderButtons extends StatelessWidget {
  final String buttonName;
  final String selectedButton;
  final ValueChanged<String> onSelected;

  const OrderButtons({
    super.key,
    required this.buttonName,
    required this.selectedButton,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: selectedButton == buttonName
                  ? Colors.orange
                  : Colors.transparent,
            ),
          ),
        ),
      ),
      onPressed: () {
        onSelected(buttonName);
      },
      child: Text(
        buttonName,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
