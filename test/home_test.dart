import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_do/db.dart';
import 'package:flutter_to_do/home.dart';
import 'package:mockito/mockito.dart';


class Db extends Mock implements DatabaseConnection{}

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Test the text fields and screen title in the home page',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: Home()));

    await tester.enterText(find.byKey(Key('titleField')), 'New Title');
    await tester.enterText(
        find.byKey(Key('descriptionField')), 'New Description');

    expect(find.text('New Title'), findsOneWidget);
    expect(find.text('New Description'), findsOneWidget);
    expect(find.text('To Do App'), findsOneWidget);
  });

  testWidgets('Test that data is saved when the Save button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: Home()));

    await tester.enterText(find.byKey(Key('titleField')), 'New Title');
    await tester.enterText(
        find.byKey(Key('descriptionField')), 'New Description');

    await tester.tap(find.byType(RaisedButton));

    await tester.pump();

    verifyNever(Db().insertItem(ToDoItem(id: 1, title: 'hey', description: 'Hello')));
  });
}
