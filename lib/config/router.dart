// Dr Papa Samour DIOP – Enseignant du cours
// Ce fichier centralise la configuration de la navigation
// entre les différents écrans de notre application.
// Nous utilisons le package go_router pour définir les routes
// et permettre à l'utilisateur de passer d'un écran à un autre.

// Importation du package go_router.
// Cette bibliothèque facilite la gestion de la navigation dans Flutter.
// Elle permet notamment de définir des chemins URL et de les associer
// aux écrans correspondants.
import 'package:go_router/go_router.dart';

// Importation de l'écran d'accueil.
// Cet écran sera associé à la route /home.
import '../screens/home_screen.dart';

// Importation de l'écran de connexion.
// Cet écran sera associé à la route /login.
import '../screens/login_screen.dart';

// Importation de l'écran de création d'un signalement.
// Cet écran sera associé à la route /report.
import '../screens/report_screen.dart';

// Déclaration de appRouter.
// Cette variable contient une instance de GoRouter qui centralise
// les règles de navigation de notre application.
// Elle sera utilisée dans le MaterialApp.router pour activer
// la navigation basée sur les routes définies ci-dessous.
final appRouter = GoRouter(

  // initialLocation définit le chemin affiché au démarrage
  // de l'application.
  // Ici, l'application ouvre automatiquement l'écran d'accueil
  // correspondant à la route /home.
  initialLocation: '/home',

  // routes contient la liste des routes disponibles.
  // Chaque GoRoute associe un chemin de navigation à un widget.
  routes: [

    // Première route : écran d'accueil.
    GoRoute(

      // path représente le chemin associé à cet écran.
      // L'utilisateur peut accéder à cet écran avec la route /home.
      path: '/home',

      // builder est une fonction chargée de construire le widget
      // correspondant à cette route.
      // Les deux paramètres anonymes _ et __ représentent le contexte
      // et l'état de la route. Ils ne sont pas utilisés ici.
      // const HomeScreen() crée l'écran d'accueil comme widget constant.
      builder: (_, __) => const HomeScreen(),
    ),

    // Deuxième route : écran de connexion.
    GoRoute(

      // Chemin permettant d'accéder à l'écran de connexion.
      path: '/login',

      // Construit et retourne le widget LoginScreen.
      // Les paramètres _ et __ ne sont pas exploités dans cette fonction.
      builder: (_, __) => const LoginScreen(),
    ),

    // Troisième route : écran de création d'un signalement.
    GoRoute(

      // Chemin associé au formulaire de signalement.
      path: '/report',

      // Construit et retourne le widget ReportScreen.
      builder: (_, __) => const ReportScreen(),
    ),
  ],
);