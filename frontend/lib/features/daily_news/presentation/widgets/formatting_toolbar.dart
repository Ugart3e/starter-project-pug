import 'package:flutter/material.dart';

import '../../../../config/theme/app_design_tokens.dart';

/// Buttons to format the text of an article: bold and subheading.
class FormattingToolbar extends StatelessWidget {
  final VoidCallback onBoldPressed;
  final VoidCallback onSubheadingPressed;

  const FormattingToolbar({
    Key? key,
    required this.onBoldPressed,
    required this.onSubheadingPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          _buildButton(Icons.format_bold, 'Bold', onBoldPressed),
          _buildButton(Icons.title, 'Subheading', onSubheadingPressed),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, String tooltip, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      iconSize: 22,
      color: AppColors.darkText,
      visualDensity: VisualDensity.compact,
      onPressed: onPressed,
    );
  }
}
