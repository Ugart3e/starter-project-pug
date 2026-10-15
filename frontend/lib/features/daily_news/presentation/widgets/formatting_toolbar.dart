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
    return Row(
      children: [
        _FormattingButton(
          label: 'B',
          tooltip: 'Bold',
          labelStyle: const TextStyle(fontWeight: FontWeight.w700),
          onPressed: onBoldPressed,
        ),
        const SizedBox(width: 8),
        _FormattingButton(
          label: 'H',
          tooltip: 'Subheading',
          labelStyle: const TextStyle(fontWeight: FontWeight.w400),
          onPressed: onSubheadingPressed,
        ),
      ],
    );
  }
}

class _FormattingButton extends StatelessWidget {
  final String label;
  final String tooltip;
  final TextStyle labelStyle;
  final VoidCallback onPressed;

  const _FormattingButton({
    required this.label,
    required this.tooltip,
    required this.labelStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppColors.lilac,
        borderRadius: AppRadius.standard,
        child: InkWell(
          borderRadius: AppRadius.standard,
          onTap: onPressed,
          child: SizedBox(
            width: 48,
            height: 40,
            child: Center(
              child: Text(
                label,
                style: labelStyle.copyWith(fontFamily: AppFonts.inter, fontSize: 18, color: AppColors.darkText),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
