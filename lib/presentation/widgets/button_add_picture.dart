import 'package:flutter/material.dart';

class ButtonAddPicture extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback action;
  const ButtonAddPicture({super.key, required this.icon, required this.label, required this.action});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: action,
      icon: icon,
      label: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
      ),
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
    );
  }
}
