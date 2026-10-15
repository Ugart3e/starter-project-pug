import 'package:flutter/services.dart';

/// Markdown marks that journalists can add while writing an article
/// (Figma annotation #3: subheadings and bold text).
class MarkdownFormatting {
  static const String boldMark = '**';
  static const String subheadingMark = '## ';

  /// Wraps the selected text in bold marks, or inserts an empty bold span at
  /// the cursor, and leaves the cursor before the closing mark.
  static TextEditingValue applyBold(TextEditingValue value) {
    final selection = _readSelection(value);
    final selectedText = selection.textInside(value.text);
    final formattedText = selection.textBefore(value.text) +
        boldMark +
        selectedText +
        boldMark +
        selection.textAfter(value.text);
    final cursorOffset = selection.start + boldMark.length + selectedText.length;
    return TextEditingValue(text: formattedText, selection: TextSelection.collapsed(offset: cursorOffset));
  }

  /// Turns the line of the cursor into a subheading, or back into normal
  /// text when it already is one.
  static TextEditingValue toggleSubheading(TextEditingValue value) {
    final selection = _readSelection(value);
    final lineStart = _findLineStart(value.text, selection.start);
    final isSubheading = value.text.startsWith(subheadingMark, lineStart);
    final lineContent = value.text.substring(lineStart + (isSubheading ? subheadingMark.length : 0));
    final formattedText =
        value.text.substring(0, lineStart) + (isSubheading ? '' : subheadingMark) + lineContent;
    final offsetChange = isSubheading ? -subheadingMark.length : subheadingMark.length;
    final cursorOffset = (selection.end + offsetChange).clamp(lineStart, formattedText.length);
    return TextEditingValue(text: formattedText, selection: TextSelection.collapsed(offset: cursorOffset));
  }

  static TextSelection _readSelection(TextEditingValue value) {
    if (value.selection.isValid) return value.selection;
    return TextSelection.collapsed(offset: value.text.length);
  }

  static int _findLineStart(String text, int offset) {
    if (offset == 0) return 0;
    return text.lastIndexOf('\n', offset - 1) + 1;
  }
}
