import 'package:flutter/material.dart';

class DefaulInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;

  const DefaulInput({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
  });

  @override
  DefaulInputState createState() => DefaulInputState();
}

class DefaulInputState extends State<DefaulInput> {
  bool passwordControll = false;

  @override
  void initState() {
    super.initState();
    passwordControll = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
        labelText: widget.label,
        border: const OutlineInputBorder(
        ),
      ),
      controller: widget.controller,
      obscureText: widget.isPassword,
      enableSuggestions: !widget.isPassword,
      autocorrect: !widget.isPassword,
    );
  }
}
