import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kngtakehome/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('add new note', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      //verify the app starts with the right widgets
      expect(find.text('NOTES'), findsOneWidget);
      expect(find.text('Create your first note!'), findsOneWidget);
      expect(find.byKey(const Key('searchButton')), findsOneWidget);
      expect(find.byKey(const Key('infoButton')), findsOneWidget);

      //find the floating button and click on it
      final Finder addButton = find.byTooltip('addNote');
      await tester.tap(addButton);

      // Trigger a frame.
      await tester.pumpAndSettle();

      //verify the right widgets for the appbar
      expect(find.byKey(const Key('backArrow')), findsOneWidget);
      expect(find.byKey(const Key('eyeIcon')), findsOneWidget);
      expect(find.byKey(const Key('saveIcon')), findsOneWidget);

      //wait for 1 second and type in the title and content of the notes
      await Future.delayed(const Duration(seconds: 2));

      final Finder titleTextField = find.byKey(const Key('titleTextField'));
      final Finder contentTextField = find.byKey(const Key('contentTextField'));
      final Finder saveIcon = find.byKey(const Key('saveIcon'));
      final Finder saveButton = find.byKey(const Key('saveButton'));

      //tap on title textfield and type some texts
      await tester.tap(titleTextField);
      await tester.enterText(titleTextField, 'Hello there');

      //delay for 2 seconds before continuing
      await Future.delayed(const Duration(seconds: 2));

      //tap on title contetntfield and type some texts
      await tester.tap(contentTextField);
      await tester.enterText(
        contentTextField,
        'This is the content of the hello there title. Be save out there!',
      );

      //delay for 2 seconds before continuing
      await Future.delayed(const Duration(seconds: 2));

      //tap on the save icon
      await tester.tap(saveIcon);

      // Trigger a frame.
      await tester.pumpAndSettle();

      //delay for 2 seconds before continuing
      await Future.delayed(const Duration(seconds: 2));

      //verify the pop with Save and Disacrd button shows
      expect(find.text('Discard'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);

      //tap the save button
      await tester.tap(saveButton);

      // Trigger a frame.
      await tester.pumpAndSettle();

      //verify the note was added
      expect(find.text('Hello there'), findsOneWidget);
      expect(find.byKey(const Key('noteContainer')), findsOneWidget);
    });

    testWidgets('edit note', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final Finder titleTextField = find.byKey(const Key('titleTextField'));
      final Finder contentTextField = find.byKey(const Key('contentTextField'));
      final Finder saveIcon = find.byKey(const Key('saveIcon'));
      final Finder saveButton = find.byKey(const Key('saveButton'));

      //delay for 2 seconds before continuing
      await Future.delayed(const Duration(seconds: 2));

      //tap on the note
      final Finder noteContainer = find.byKey(const Key('noteContainer'));
      await tester.tap(noteContainer);

      // Trigger a frame.
      await tester.pumpAndSettle();

      //verify appbar icons
      expect(find.byKey(const Key('backArrow')), findsOneWidget);
      expect(find.byKey(const Key('editIcon')), findsOneWidget);

      //tap on the edit icon
      final Finder editIcon = find.byKey(const Key('editIcon'));
      await tester.tap(editIcon);

      // Trigger a frame.
      await tester.pumpAndSettle();

      //delay for 2 seconds before continuing
      await Future.delayed(const Duration(seconds: 2));

      //tap on title textfield and type some texts
      await tester.tap(titleTextField);
      await tester.enterText(titleTextField, 'Hello there edited title');

      //delay for 2 seconds before continuing
      await Future.delayed(const Duration(seconds: 2));

      //tap on title contetntfield and type some texts
      await tester.tap(contentTextField);
      await tester.enterText(
        contentTextField,
        'This is the content of the hello there title. Be save out there! and this is edited version',
      );

      //delay for 2 seconds before continuing
      await Future.delayed(const Duration(seconds: 2));

      //tap on the save icon
      await tester.tap(saveIcon);

      // Trigger a frame.
      await tester.pumpAndSettle();

      //delay for 2 seconds before continuing
      await Future.delayed(const Duration(seconds: 2));

      //verify the pop with Save and Disacrd button shows
      expect(find.text('Discard'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);

      //tap the save button
      await tester.tap(saveButton);

      // Trigger a frame.
      await tester.pumpAndSettle();

      //verify the edited notes
      expect(find.text('Hello there edited title'), findsOneWidget);
      expect(
          find.text(
              'This is the content of the hello there title. Be save out there! and this is edited version'),
          findsOneWidget);

      //delay for 2 seconds before continuing
      await Future.delayed(const Duration(seconds: 2));

      //find the back button and tap on it
      final Finder backButton = find.byKey(const Key('backArrow'));
      await tester.tap(backButton);

      // Trigger a frame.
      await tester.pumpAndSettle();

      //verify the edited notes title on home page
      expect(find.text('Hello there edited title'), findsOneWidget);

      //delay for 2 seconds adn exit the test
      await Future.delayed(const Duration(seconds: 2));
    });
  });
}
