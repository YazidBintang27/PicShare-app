import 'package:flutter/material.dart';

class ButtonFill extends StatelessWidget {
  final String text;
  final VoidCallback action;
  const ButtonFill({super.key, required this.text, required this.action});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            minimumSize: WidgetStateProperty.all(Size(double.infinity, 52)),
            backgroundColor:
                WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)))),
        onPressed: action,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.white),
        ));
  }
}
