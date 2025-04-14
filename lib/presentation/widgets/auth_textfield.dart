import 'package:flutter/material.dart';

class AuthTextfield extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  const AuthTextfield(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      this.suffixIcon,
      required this.controller,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 20),
      child: TextField(
        controller: controller,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.bold),
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Color.fromARGB(178, 38, 38, 38)),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: Color(0xFFEEEEEE),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 1))),
      ),
    );
  }
}
