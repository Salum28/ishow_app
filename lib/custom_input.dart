import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  // Variables
  final String? hint;
  final bool? obscure;
  final Icon? icon;

  const CustomInput({super.key, @required this.hint, this.obscure = false, this.icon = const Icon(Icons.person)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(8),
      child:TextField(
        keyboardType: TextInputType.text,
        obscureText: obscure!,
        decoration: InputDecoration(
          icon: icon,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 18
          )
        ),
      )
    );
  }
}
