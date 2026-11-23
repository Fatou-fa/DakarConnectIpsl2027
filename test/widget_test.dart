// Test de l'écran de connexion (mode démonstration du cours).
//
// MyApp est construit directement, sans passer par main() :
// Firebase n'est donc pas initialisé ici, ce qui convient car les écrans
// du cours n'utilisent pas encore Firebase.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dakarconnectipsl2027/main.dart';

void main() {
  testWidgets("L'application démarre sur l'écran de connexion",
      (WidgetTester tester) async {
    // ProviderScope est obligatoire pour utiliser Riverpod.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(find.text('Bienvenue !'), findsOneWidget);
    expect(find.text('Se connecter'), findsOneWidget);
  });

  testWidgets('Après connexion, les signalements récents sont affichés',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    // Saisie d'un identifiant et d'un mot de passe de 6 caractères
    await tester.enterText(find.byType(TextFormField).at(0), 'etudiant@ipsl.sn');
    await tester.enterText(find.byType(TextFormField).at(1), 'secret');
    await tester.tap(find.text('Se connecter'));
    await tester.pumpAndSettle();

    expect(find.text('Signalements récents'), findsOneWidget);
  });
}
