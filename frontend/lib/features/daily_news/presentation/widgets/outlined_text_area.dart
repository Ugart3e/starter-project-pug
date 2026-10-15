import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/theme/app_design_tokens.dart';

/// Text input drawn as the bordered boxes of the publishing screen.
/// It fills the height given by its parent.
class OutlinedTextArea extends StatelessWidget {
  final String hintText;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final int maxLength;
  final bool hasError;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;

  const OutlinedTextArea({
    Key? key,
    required this.hintText,
    required this.textStyle,
    required this.hintStyle,
    required this.maxLength,
    required this.onChanged,
    this.hasError = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      expands: true,
      maxLines: null,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      style: textStyle,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        counterText: '',
        contentPadding: const EdgeInsets.all(16),
        enabledBorder: _buildBorder(hasError ? AppColors.error : AppColors.inputBorder),
        focusedBorder: _buildBorder(hasError ? AppColors.error : AppColors.darkText),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: AppRadius.standard,
      borderSide: BorderSide(color: color),
    );
  }
}
