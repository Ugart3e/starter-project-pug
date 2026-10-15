import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/widgets/article_content_editor.dart';

void main() {
  late List<String> changedContents;

  setUp(() => changedContents = []);

  Future<void> pumpEditor(WidgetTester tester, {int maxLength = 5000}) {
    return tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SizedBox(
          height: 300,
          child: ArticleContentEditor(
            hintText: 'Add article here, .....',
            textStyle: const TextStyle(),
            hintStyle: const TextStyle(),
            maxLength: maxLength,
            onChanged: changedContents.add,
          ),
        ),
      ),
    ));
  }

  group('ArticleContentEditor', () {
    testWidgets('reports the written content', (tester) async {
      await pumpEditor(tester);

      await tester.enterText(find.byType(TextField), 'Breaking news');

      expect(changedContents.last, 'Breaking news');
    });

    testWidgets('adds bold marks and reports the formatted content', (tester) async {
      await pumpEditor(tester);
      await tester.enterText(find.byType(TextField), 'Breaking ');

      await tester.tap(find.byTooltip('Bold'));
      await tester.pump();

      expect(changedContents.last, 'Breaking ****');
      expect(find.text('Breaking ****'), findsOneWidget);
    });

    testWidgets('turns the current line into a subheading', (tester) async {
      await pumpEditor(tester);
      await tester.enterText(find.byType(TextField), 'Key facts');

      await tester.tap(find.byTooltip('Subheading'));
      await tester.pump();

      expect(changedContents.last, '## Key facts');
    });

    testWidgets('does not format when the result would exceed the maximum length', (tester) async {
      await pumpEditor(tester, maxLength: 10);
      await tester.enterText(find.byType(TextField), 'Breaking');

      await tester.tap(find.byTooltip('Bold'));
      await tester.pump();

      expect(changedContents.last, 'Breaking');
    });
  });
}
