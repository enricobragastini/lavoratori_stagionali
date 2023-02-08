import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar(
      {super.key,
      required this.onChanged,
      this.fillColor,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon});

  final void Function(String) onChanged;
  final Color? fillColor;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      key: const Key('searchbar_textField'),
      onChanged: (string) => onChanged(string),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 30),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: suffixIcon,
        ),
      ),
    );
  }
}
