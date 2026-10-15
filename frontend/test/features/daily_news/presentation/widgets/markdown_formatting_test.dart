import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/widgets/markdown_formatting.dart';

void main() {
  TextEditingValue buildValue(String text, {required int start, int? end}) {
    return TextEditingValue(text: text, selection: TextSelection(baseOffset: start, extentOffset: end ?? start));
  }

  group('MarkdownFormatting.applyBold', () {
    test('wraps the selected text in bold marks', () {
      final value = MarkdownFormatting.applyBold(buildValue('Breaking news today', start: 9, end: 13));

      expect(value.text, 'Breaking **news** today');
      expect(value.selection, const TextSelection.collapsed(offset: 15));
    });

    test('inserts an empty bold span at the cursor', () {
      final value = MarkdownFormatting.applyBold(buildValue('Breaking ', start: 9));

      expect(value.text, 'Breaking ****');
      expect(value.selection, const TextSelection.collapsed(offset: 11));
    });

    test('adds the marks at the end when the field has no cursor', () {
      const value = TextEditingValue(text: 'Text');

      expect(MarkdownFormatting.applyBold(value).text, 'Text****');
    });
  });

  group('MarkdownFormatting.toggleSubheading', () {
    test('turns the line of the cursor into a subheading', () {
      final value = MarkdownFormatting.toggleSubheading(buildValue('Intro\nKey facts\nEnd', start: 9));

      expect(value.text, 'Intro\n## Key facts\nEnd');
      expect(value.selection, const TextSelection.collapsed(offset: 12));
    });

    test('works on the first line', () {
      expect(MarkdownFormatting.toggleSubheading(buildValue('Key facts', start: 0)).text, '## Key facts');
    });

    test('turns a subheading back into normal text', () {
      final value = MarkdownFormatting.toggleSubheading(buildValue('Intro\n## Key facts', start: 14));

      expect(value.text, 'Intro\nKey facts');
      expect(value.selection, const TextSelection.collapsed(offset: 11));
    });
  });
}
