import 'package:flutter_test/flutter_test.dart';
import 'package:mychild/main.dart';

voidmain() {
  testWidgets('Activation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyChildApp(isActivated: false));

    // Tu peux adapter les vérifications selon ton écran d’accueil
    expect(find.text('My Child'), findsOneWidget);
  });
}
