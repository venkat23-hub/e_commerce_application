import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_application/features/home/presentation/home_screen.dart';
import 'package:e_commerce_application/features/home/providers/home_provider.dart';

void main() {
  testWidgets('Home Screen loads products and displays them', (WidgetTester tester) async {
    // Create a test provider for HomeProvider
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeProvider()),
        ],
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // Verify that the loading indicator is shown initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for data to load
    await tester.pumpAndSettle();

    // Verify that products are displayed (assuming at least one product is loaded)
    expect(find.byType(ListTile), findsWidgets);
  });
}
