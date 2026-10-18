import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/main.dart';

void main() {
  const testResolutions = [
    Size(360, 780),   // Small Mobile
    Size(414, 896),   // Large Mobile
    Size(600, 960),   // Phablet / Mini Tablet
    Size(768, 1024),  // Tablet Portrait
    Size(1024, 768),  // Tablet Landscape
    Size(1280, 800),  // Standard Laptop
    Size(1440, 900),  // High-Res Desktop
    Size(1920, 1080), // Full HD Desktop
  ];

  for (final resolution in testResolutions) {
    testWidgets(
      'Audit layout for overflow errors at ${resolution.width.toInt()}x${resolution.height.toInt()}',
      (WidgetTester tester) async {
        tester.view.physicalSize = resolution;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(const PortfolioApp());
        await tester.pumpAndSettle();

        expect(find.byType(PortfolioApp), findsOneWidget);

        // Scroll through the entire page to verify all sections and components without RenderFlex overflow
        final scrollableFinder = find.byType(Scrollable).first;
        await tester.drag(scrollableFinder, const Offset(0, -600));
        await tester.pumpAndSettle();

        await tester.drag(scrollableFinder, const Offset(0, -800));
        await tester.pumpAndSettle();

        await tester.drag(scrollableFinder, const Offset(0, -1000));
        await tester.pumpAndSettle();

        await tester.drag(scrollableFinder, const Offset(0, -1200));
        await tester.pumpAndSettle();

        // Scroll back to top
        await tester.drag(scrollableFinder, const Offset(0, 3600));
        await tester.pumpAndSettle();
      },
    );
  }
}
