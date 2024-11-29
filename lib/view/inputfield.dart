import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool isEmail;
  final bool passwordInvisible;

  const InputField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.isEmail = false,
    this.passwordInvisible = false,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),


      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.passwordInvisible && !_isPasswordVisible,
        keyboardType: widget.isEmail ? TextInputType.emailAddress : TextInputType.text,

        decoration: InputDecoration(
          labelText: widget.hint,
          hintText: widget.hint,
          prefixIcon: Icon(widget.icon),
          enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            )),
          suffixIcon: widget.passwordInvisible
              ? IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto, // Show label above the field when focused
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${widget.hint}';
          }
          if (widget.isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Please enter a valid email address';
          }

          return null;
        },
      ),
    );
  }
}