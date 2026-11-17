import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/router.dart';

// Dr Papa Samour DIOP – Enseignant du cours
// Point d'entrée principal de l'application Flutter.
// runApp() démarre l'application et affiche le widget racine.
void main() => runApp(const ProviderScope(child: MyApp()));

// ProviderScope initialise l'environnement Riverpod.
// Il permet aux widgets descendants d'accéder aux providers
// et de partager les états gérés par Riverpod.

class MyApp extends ConsumerWidget {
  // ConsumerWidget permet à ce widget d'accéder aux providers
  // grâce à WidgetRef, notamment pour récupérer la configuration du routeur.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    // title définit le nom de l'application utilisé notamment
    // par certaines plateformes pour identifier l'application.
    title: 'DakarConnect',

    // Désactive le bandeau DEBUG affiché en haut à droite
    // pendant l'exécution en mode développement.
    debugShowCheckedModeBanner: false,

    // ThemeData définit le thème visuel général de l'application.
    // colorSchemeSeed génère une palette de couleurs à partir d'Indigo.
    // useMaterial3 active les composants et styles de Material Design 3.
    theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),

    // MaterialApp.router configure l'application pour utiliser
    // un système de navigation externe, ici GoRouter.
    // ref.watch() observe routerProvider et récupère l'instance du routeur.
    // Si ce provider change, le widget MyApp est reconstruit.
    routerConfig: ref.watch(routerProvider),
  );
}
