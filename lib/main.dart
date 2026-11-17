// Dr Papa Samour DIOP – Enseignant du cours
// Ce fichier constitue le point d'entrée de notre application Flutter.
// Il initialise l'application et configure les principaux éléments
// nécessaires à son fonctionnement.

// Importation de la bibliothèque Material de Flutter.
// Elle fournit les composants graphiques et les fonctionnalités
// nécessaires à la construction de l'interface.
import 'package:flutter/material.dart';

// Importation de Flutter Riverpod.
// Cette bibliothèque permet de gérer et de partager l'état
// de l'application entre différents widgets.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Importation du fichier de configuration des routes.
// Il contient les chemins de navigation et les écrans associés.
import 'config/router.dart';

// Fonction principale de l'application.
// Flutter exécute cette fonction au démarrage du programme.
// runApp() reçoit le widget racine et lance l'affichage de l'application.
void main() => runApp(const ProviderScope(child: MyApp()));

// Déclaration du widget principal de l'application.
// StatelessWidget indique que ce widget ne gère pas directement
// un état interne modifiable.
class MyApp extends StatelessWidget {
  // Constructeur de MyApp.
  // super.key transmet la clé éventuelle au constructeur parent.
  const MyApp({super.key});

  // Redéfinition de la méthode build.
  // Cette méthode décrit l'interface principale de l'application.
  // BuildContext représente le contexte de ce widget dans l'arbre Flutter.
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    // Définition du nom de l'application.
    // Ce titre peut notamment être utilisé par certaines plateformes.
    title: 'DakarConnect',

    // Désactivation de la bannière DEBUG affichée
    // habituellement en haut à droite en mode développement.
    debugShowCheckedModeBanner: false,

    // Configuration du thème général de l'application.
    theme: ThemeData(
      // Définition de la couleur principale utilisée
      // pour générer les différentes couleurs du thème.
      colorSchemeSeed: Colors.indigo,

      // Activation de Material Design 3.
      // Cette option permet d'utiliser les composants
      // et les styles modernes de l'interface Material.
      useMaterial3: true,
    ),

    // Association de la configuration des routes à l'application.
    // appRouter est défini dans le fichier config/router.dart.
    // Il permet de déterminer quel écran afficher selon
    // le chemin de navigation demandé.
    routerConfig: appRouter,
  );
}
