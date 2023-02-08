import 'package:flutter/material.dart';

class MultiSelectorWidget extends StatelessWidget {
  const MultiSelectorWidget({
    super.key,
    required this.title,
    required this.list,
    required this.selected,
    required this.onAdd,
    required this.onDelete,
  });

  final String title;
  final List<String> list;
  final List<String> selected;
  final void Function(String) onAdd;
  final void Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          SizedBox(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
              ),
            ),
        ],
      ),
    );
  }
}
