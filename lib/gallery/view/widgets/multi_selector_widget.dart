import 'package:flutter/material.dart';

class MultiSelectorWidget extends StatelessWidget {
  const MultiSelectorWidget({
    super.key,
    this.width,
    required this.title,
    required this.list,
    required this.selected,
    this.onPressed,
    required this.onAdd,
    required this.onDelete,
  });

  final double? width;
  final String title;
  final List<String> list;
  final List<String> selected;
  final void Function(bool)? onPressed;
  final void Function(String) onAdd;
  final void Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    for (final element in list) {
      print("$element --- ");
    }
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        for (final element in list)
          SizedBox(
            child: InputChip(
              label: Text(element),
              selected: selected.contains(element),
              onPressed: selected.contains(element)
                  ? () => onDelete(element)
                  : () => onAdd(element),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            ),
          ),
      ],
    );
  }
}
