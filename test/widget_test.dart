// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:booking_appointment_app/main.dart';

void main() {
  testWidgets('booking flow completes successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Book an appointment'), findsOneWidget);
    expect(find.text('Dr. Maya Chen'), findsOneWidget);

    await tester.ensureVisible(find.text('Book now'));
    await tester.tap(find.text('Book now'));
    await tester.pumpAndSettle();

    expect(find.text('Appointment booked!'), findsOneWidget);
  });
}
