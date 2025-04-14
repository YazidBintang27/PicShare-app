import 'package:flutter/material.dart';

class ButtonStroke extends StatelessWidget {
  final String text;
  final VoidCallback action;
  const ButtonStroke({super.key, required this.text, required this.action});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            side: WidgetStateProperty.all(
              BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            minimumSize: WidgetStateProperty.all(Size(double.infinity, 52)),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ))),
        onPressed: action,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ));
  }
}
