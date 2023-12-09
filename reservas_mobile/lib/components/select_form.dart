import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:google_fonts/google_fonts.dart';

class SelectForm extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function tap;
  final List options;
  final String? validationMessage;

  const SelectForm(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.tap,
      required this.options,
      this.validationMessage});

  @override
  SelectFormState createState() => SelectFormState();
}

class SelectFormState extends State<SelectForm> {
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFF7F7FB),
          ),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                setState(() {
                  _errorMessage = widget.validationMessage;
                });

                return widget.validationMessage;
              }

              setState(() {
                _errorMessage = null;
              });
              return null;
            },
            onTap: () {
              widget.tap(
                  context, widget.hintText, widget.controller, widget.options);
            },
            readOnly: true,
            controller: widget.controller,
            // style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              errorMaxLines: null,
              errorText: '',
              errorStyle: const TextStyle(
                color: Colors.transparent,
                fontSize: 0,
                height: 0.01,
              ),
              suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
              suffixIconColor: const Color(0xFF000000),
              contentPadding: const EdgeInsets.fromLTRB(20, 8, 15, 8),
              border: InputBorder.none,
              labelText: widget.hintText,
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              labelStyle: TextStyle(
                color: widget.controller.text != ''
                    ? Colors.black
                    : const Color.fromARGB(255, 98, 98, 98),
              ),
            ),
          ),
        ),
        _errorMessage == null
            ? const SizedBox()
            : Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                  child: Text(
                    _errorMessage!,
                    // style: GoogleFonts.poppins(
                    //   fontWeight: FontWeight.w500,
                    //   fontSize: 12,
                    //   color: Colors.red[300],
                    // ),
                  ),
                ),
              )
      ],
    );
  }
}
