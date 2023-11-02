import 'package:flutter/material.dart';

class CardListItem extends StatelessWidget {
  const CardListItem(
      {required this.title, required this.onPressed, this.subtitle, super.key});

  final String title;
  final String? subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: ElevatedButton(
          onPressed: onPressed,
          child: const Text('View'),
        ),
      ),
    );
  }
}
