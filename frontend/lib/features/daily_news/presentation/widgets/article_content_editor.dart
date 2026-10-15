import 'package:flutter/material.dart';

import 'formatting_toolbar.dart';
import 'markdown_formatting.dart';
import 'outlined_text_area.dart';

/// Box to write the content of an article, with buttons to add bold text
/// and subheadings. It fills the height given by its parent.
class ArticleContentEditor extends StatefulWidget {
  final String hintText;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final int maxLength;
  final bool hasError;
  final ValueChanged<String> onChanged;

  const ArticleContentEditor({
    Key? key,
    required this.hintText,
    required this.textStyle,
    required this.hintStyle,
    required this.maxLength,
    required this.onChanged,
    this.hasError = false,
  }) : super(key: key);

  @override
  State<ArticleContentEditor> createState() => _ArticleContentEditorState();
}

class _ArticleContentEditorState extends State<ArticleContentEditor> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormattingToolbar(
          onBoldPressed: () => _applyFormatting(MarkdownFormatting.applyBold),
          onSubheadingPressed: () => _applyFormatting(MarkdownFormatting.toggleSubheading),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: OutlinedTextArea(
            controller: _controller,
            hintText: widget.hintText,
            textStyle: widget.textStyle,
            hintStyle: widget.hintStyle,
            maxLength: widget.maxLength,
            hasError: widget.hasError,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }

  /// Formats the text unless the result would exceed the maximum length.
  void _applyFormatting(TextEditingValue Function(TextEditingValue value) format) {
    final formattedValue = format(_controller.value);
    if (formattedValue.text.length > widget.maxLength) return;
    _controller.value = formattedValue;
    widget.onChanged(formattedValue.text);
  }
}
