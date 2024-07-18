import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class LoginTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  const LoginTextField({required this.controller,required this.hintText,required this.obscure});
  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20
      ),
      child: TextField(
        controller: this.widget.controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.transparent
            )
          ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white
                )
            ),
          fillColor: Colors.indigo.shade200,
          filled: true,
          hintText: this.widget.hintText
        ),
        obscureText: this.widget.obscure,
      ),
    );
  }
}
