import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.textFormFieldKey,
      this.textFormFieldController,
      this.onChangedAction,
      this.onTapAction,
      this.onFocusChangeAction,
      this.validator,
      required this.labelText,
      containerHeight}) {
    this.containerHeight = containerHeight ?? 85;
  }

  final Key? textFormFieldKey;
  final TextEditingController? textFormFieldController;

  final void Function(bool)? onFocusChangeAction;
  final void Function(String)? onChangedAction;
  final void Function()? onTapAction;
  final String? Function(String?)? validator;

  final String labelText;

  late final double? containerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      constraints: const BoxConstraints(maxWidth: 700),
      child: Center(
        child: Focus(
          onFocusChange: onFocusChangeAction,
          child: TextFormField(
              key: textFormFieldKey,
              controller: textFormFieldController,
              onTap: onTapAction,
              onChanged: onChangedAction,
              decoration: InputDecoration(
                labelText: labelText,
              ),
              validator: validator),
        ),
      ),
    );
  }
}
